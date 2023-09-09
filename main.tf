#--------------------------------------------------------------
# Labeling
#--------------------------------------------------------------

module "igw_label" {
  source     = "cloudposse/label/null"
  version    = "0.25.0"
  attributes = compact(concat(module.this.attributes, ["igw"]))
  context    = module.this.context
  enabled    = module.this.enabled && var.enable_internet_gateway
}

module "public_label" {
  source     = "cloudposse/label/null"
  version    = "0.25.0"
  attributes = compact(concat(module.this.attributes, ["public"]))
  context    = module.this.context
  enabled    = module.this.enabled
}

module "private_label" {
  source     = "cloudposse/label/null"
  version    = "0.25.0"
  attributes = compact(concat(module.this.attributes, ["private"]))
  context    = module.this.context
  enabled    = module.this.enabled
}

#--------------------------------------------------------------
# SSH Key
#--------------------------------------------------------------

module "ssh_key" {
  source                 = "./modules/ssh-key"
  context                = module.this.context
  enabled                = module.this.enabled
  algorithm              = var.algorithm
  ecdsa_curve            = var.ecdsa_curve
  generate_ssh_key       = var.generate_ssh_key
  local_download_enabled = var.local_download_enabled
  local_ssh_key_path     = var.local_ssh_key_path
  rsa_bits               = var.rsa_bits
  ssh_key_name           = var.ssh_key_name
  ssh_public_key_file    = var.ssh_public_key_file
}

#--------------------------------------------------------------
# VPC
#--------------------------------------------------------------

resource "digitalocean_vpc" "this" {
  count       = module.this.enabled ? 1 : 0
  name        = coalesce(var.vpc_name, module.this.id)
  region      = var.vpc_region
  description = var.vpc_description
  ip_range    = var.vpc_ip_range
}

#--------------------------------------------------------------
# Floating IP
#--------------------------------------------------------------

resource "digitalocean_floating_ip" "igw" {
  count  = module.igw_label.enabled ? 1 : 0
  region = digitalocean_vpc.this[0].region
}

#--------------------------------------------------------------
# Internet Gateway Cloud-Init
#--------------------------------------------------------------

data "cloudinit_config" "igw" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    content      = <<-CLOUDCONFIG
      output: {
        all: '| tee -a /var/log/cloud-init-output.log'
      }
    CLOUDCONFIG
  }

  part {
    content_type = "text/x-shellscript"
    filename     = "part-01-configure-vpc-gateway.sh"
    content      = <<-CLOUDCONFIG
      #!/usr/bin/env bash

      # suppress iptables-persistent prompt
      echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
      echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections
    
      # packages
      apt-get update
      apt-get install --no-install-recommends -y \
        bash \
        ca-certificates \
        curl \
        iptables \
        iptables-persistent \
        net-tools

      # How to Configure a Droplet as a VPC Gateway
      # https://docs.digitalocean.com/products/networking/vpc/how-to/configure-droplet-as-gateway/

      # ip forwarding
      sysctl -w net.ipv4.ip_forward=1
      sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf

      # configure nat
      echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
      echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections
      inf=$(route -n | awk '$1 == "0.0.0.0" {print $8}')
      iptables -t nat -A POSTROUTING -s ${digitalocean_vpc.this[0].ip_range} -o $${inf} -j MASQUERADE
      iptables-save > /etc/iptables/rules.v4
    CLOUDCONFIG
  }

  dynamic "part" {
    for_each = var.igw_droplet_enable_bastion ? [0] : []
    content {
      content_type = "text/x-shellscript"
      filename     = "part-02-configure-fail2ban.sh"
      content      = <<-CLOUDCONFIG
        #!/usr/bin/env bash

        # packages
        apt-get update
        apt-get install --no-install-recommends -y \
          fail2ban

        # sshd rules
        cat <<-'EOF' > /etc/fail2ban/jail.d/defaults-debian.conf
        [sshd]
        enabled = true
        port = ssh
        filter = sshd
        logpath = /var/log/auth.log
        maxretry = 3
        banaction = iptables-multiport
                    slack-notify
        EOF

        # slack-notify
        curl -fsSL --netrc-optional https://raw.githubusercontent.com/hansohn/fail2ban-slack-action/master/slack-notify.conf \
          --output /etc/fail2ban/action.d/slack-notify.conf

        # fail2ban service override.conf
        if [ "${var.igw_droplet_enable_notifications}" == "true" ]; then
          mkdir -p /etc/systemd/system/fail2ban.service.d
          cat <<-'EOF' >> /etc/systemd/system/fail2ban.service.d/override.conf
        [Service]
        Environment=SLACK_CHANNEL=${var.slack_channel}
        Environment=SLACK_USERNAME=${var.slack_username}
        Environment=SLACK_ICON=${var.slack_icon}
        Environment=SLACK_WEBHOOK_URL=${var.slack_webhook_url}
        EOF
        fi

        systemctl daemon-reload
        systemctl restart fail2ban
      CLOUDCONFIG
    }
  }

  dynamic "part" {
    for_each = var.igw_droplet_cloudinit_parts
    content {
      content      = lookup(part.value, "content")
      filename     = lookup(part.value, "filename", null)
      content_type = lookup(part.value, "content_type", null)
      merge_type   = lookup(part.value, "merge_type", null)
    }
  }
}

#--------------------------------------------------------------
# Internet Gateway Droplet
#--------------------------------------------------------------

resource "digitalocean_droplet" "igw" {
  count       = module.igw_label.enabled ? 1 : 0
  image       = var.igw_droplet_image
  name        = coalesce(var.igw_droplet_name, module.igw_label.id)
  region      = digitalocean_vpc.this[0].region
  size        = var.igw_droplet_size
  backups     = var.igw_droplet_backups
  monitoring  = var.igw_droplet_monitoring
  ipv6        = var.igw_droplet_ipv6
  vpc_uuid    = digitalocean_vpc.this[0].id
  ssh_keys    = compact(setunion(var.igw_droplet_ssh_keys, [module.ssh_key.key_fingerprint]))
  resize_disk = var.igw_droplet_resize_disk
  tags        = compact(setunion(var.igw_droplet_tags, [for k, v in module.igw_label.tags : v if k != "Name"]))
  user_data   = data.cloudinit_config.igw.rendered
  volume_ids  = var.igw_droplet_volume_ids
}

#--------------------------------------------------------------
# Internet Gateway Volume
#--------------------------------------------------------------

resource "digitalocean_volume" "igw" {
  count                    = module.igw_label.enabled && var.igw_volume_enabled ? 1 : 0
  region                   = digitalocean_vpc.this[0].region
  name                     = var.igw_volume_name
  size                     = var.igw_volume_size
  description              = var.igw_volume_description
  snapshot_id              = var.igw_volume_snapshot_id
  initial_filesystem_type  = var.igw_volume_initial_filesystem_type
  initial_filesystem_label = var.igw_volume_initial_filesystem_label
  tags                     = compact(setunion(var.igw_volume_tags, [for k, v in module.igw_label.tags : v if k != "Name"]))
}

resource "digitalocean_volume_attachment" "igw" {
  count      = module.igw_label.enabled && var.igw_volume_enabled ? 1 : 0
  droplet_id = digitalocean_droplet.igw[0].id
  volume_id  = digitalocean_volume.igw[0].id
}

#--------------------------------------------------------------
# Internet Gateway IP Assignemnt
#--------------------------------------------------------------

resource "digitalocean_floating_ip_assignment" "igw" {
  count      = module.igw_label.enabled ? 1 : 0
  ip_address = digitalocean_floating_ip.igw[0].ip_address
  droplet_id = digitalocean_droplet.igw[0].id
}

#--------------------------------------------------------------
# Public Load Balancer
#--------------------------------------------------------------

resource "digitalocean_loadbalancer" "public" {
  count     = var.private_droplet_count > 1 ? 1 : 0
  name      = coalesce(var.public_lb_name, module.public_label.id)
  region    = digitalocean_vpc.this[0].region
  size      = var.public_lb_size
  size_unit = var.public_lb_size_unit
  algorithm = var.public_lb_algorithm
  dynamic "forwarding_rule" {
    for_each = var.public_lb_forwarding_rule
    content {
      entry_protocol   = lookup(forwarding_rule.value, "entry_protocol")
      entry_port       = lookup(forwarding_rule.value, "entry_port")
      target_protocol  = lookup(forwarding_rule.value, "target_protocol")
      target_port      = lookup(forwarding_rule.value, "target_port")
      certificate_name = lookup(forwarding_rule.value, "certificate_name", null)
      certificate_id   = lookup(forwarding_rule.value, "certificate_id", null)
      tls_passthrough  = lookup(forwarding_rule.value, "tls_passthrough", null)
    }
  }
  dynamic "healthcheck" {
    for_each = var.public_lb_healthcheck
    content {
      protocol                 = lookup(healthcheck.value, "protocol")
      port                     = lookup(healthcheck.value, "port", null)
      path                     = lookup(healthcheck.value, "path", null)
      check_interval_seconds   = lookup(healthcheck.value, "check_interval_seconds", null)
      response_timeout_seconds = lookup(healthcheck.value, "response_timeout_seconds", null)
      unhealthy_threshold      = lookup(healthcheck.value, "unhealthy_threshold", null)
      healthy_threshold        = lookup(healthcheck.value, "healthy_threshold", null)
    }
  }
  dynamic "sticky_sessions" {
    for_each = var.public_lb_sticky_sessions
    content {
      type               = lookup(sticky_sessions.value, "type")
      cookie_name        = lookup(sticky_sessions.value, "cookie_name", null)
      cookie_ttl_seconds = lookup(sticky_sessions.value, "cookie_ttl_seconds", null)
    }
  }
  redirect_http_to_https           = var.public_lb_redirect_http_to_https
  enable_proxy_protocol            = var.public_lb_enable_proxy_protocol
  enable_backend_keepalive         = var.public_lb_enable_backend_keepalive
  http_idle_timeout_seconds        = var.public_lb_http_idle_timeout_seconds
  disable_lets_encrypt_dns_records = var.public_lb_disable_lets_encrypt_dns_records
  project_id                       = var.public_lb_project_id
  vpc_uuid                         = digitalocean_vpc.this[0].id
  droplet_ids                      = var.public_lb_droplet_ids
  droplet_tag                      = var.public_lb_droplet_tag
  dynamic "firewall" {
    for_each = var.public_lb_firewall
    content {
      deny  = lookup(firewall.value, "deny", null)
      allow = lookup(firewall.value, "allow", null)
    }
  }
}

#--------------------------------------------------------------
# Public Firewall
#--------------------------------------------------------------

data "http" "myip" {
  count = var.firewall_allow_myip_ssh || var.firewall_allow_myip_web ? 1 : 0
  url   = "https://ipinfo.io/ip/"
}

locals {
  public_firewall_inbound_myip_ssh = module.igw_label.enabled && var.firewall_allow_myip_ssh ? [
    tomap({
      protocol         = "tcp"
      port_range       = "22"
      source_addresses = "${chomp(data.http.myip[0].body)}/32"
    })
  ] : []
  public_firewall_inbound_myip_web = var.private_droplet_count > 1 && var.firewall_allow_myip_web ? [
    tomap({
      protocol         = "tcp"
      port_range       = "80"
      source_addresses = "${chomp(data.http.myip[0].body)}/32"
    }),
    tomap({
      protocol         = "tcp"
      port_range       = "443"
      source_addresses = "${chomp(data.http.myip[0].body)}/32"
    }),
  ] : []
  public_firewall_inbound_rules = concat(local.public_firewall_inbound_myip_ssh, local.public_firewall_inbound_myip_web)
}

resource "digitalocean_firewall" "public" {
  count       = module.public_label.enabled ? 1 : 0
  name        = coalesce(var.public_firewall_name, module.public_label.id)
  droplet_ids = digitalocean_droplet.igw[*].id
  tags        = var.public_firewall_tags
  dynamic "inbound_rule" {
    for_each = concat(local.public_firewall_inbound_rules, var.public_firewall_inbound_rules)
    content {
      protocol                  = lookup(inbound_rule.value, "protocol", null)
      port_range                = lookup(inbound_rule.value, "port_range", null)
      source_addresses          = lookup(inbound_rule.value, "source_addresses", null) != null ? split(",", lookup(inbound_rule.value, "source_addresses")) : null
      source_droplet_ids        = lookup(inbound_rule.value, "source_droplet_ids", null) != null ? split(",", lookup(inbound_rule.value, "source_droplet_ids")) : null
      source_tags               = lookup(inbound_rule.value, "source_tags", null) != null ? split(",", lookup(inbound_rule.value, "source_tags")) : null
      source_load_balancer_uids = lookup(inbound_rule.value, "source_load_balancer_uids", null) != null ? split(",", lookup(inbound_rule.value, "source_load_balancer_uids")) : null
    }
  }
  dynamic "outbound_rule" {
    for_each = var.public_firewall_outbound_rules
    content {
      protocol                       = lookup(outbound_rule.value, "protocol", null)
      port_range                     = lookup(outbound_rule.value, "port_range", null)
      destination_addresses          = lookup(outbound_rule.value, "destination_addresses", null) != null ? split(",", lookup(outbound_rule.value, "destination_addresses")) : null
      destination_droplet_ids        = lookup(outbound_rule.value, "destination_droplet_ids", null) != null ? split(",", lookup(outbound_rule.value, "destination_droplet_ids")) : null
      destination_tags               = lookup(outbound_rule.value, "destination_tags", null) != null ? split(",", lookup(outbound_rule.value, "destination_tags")) : null
      destination_load_balancer_uids = lookup(outbound_rule.value, "destination_load_balancer_uids", null) != null ? split(",", lookup(outbound_rule.value, "destinattion_load_balancer_uids")) : null
    }
  }
}

#--------------------------------------------------------------
# Private Droplet Cloud-Init
#--------------------------------------------------------------

data "cloudinit_config" "private" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content      = <<-CLOUDCONFIG
      output: {
        all: '| tee -a /var/log/cloud-init-output.log'
      }
    CLOUDCONFIG
  }

  part {
    content_type = "text/x-shellscript"
    content      = <<-CLOUDCONFIG
      #!/usr/bin/env bash
      set -e

      # packages
      apt-get update
      apt-get install --no-install-recommends -y \
        bash \
        ca-certificates \
        curl \
        jq \
        tmux \
        vim

      # How to Configure a Droplet as a VPC Gateway
      # https://www.digitalocean.com/docs/networking/vpc/resources/droplet-as-gateway/

      # route external traffic though internet gateway
      gw=$(route -n | awk '$1 == "0.0.0.0" {print $2}')
      ip route add 169.254.169.254 via "$${gw}" dev eth0
      ip route change default via ${digitalocean_droplet.igw[0].ipv4_address_private}
    CLOUDCONFIG
  }

  dynamic "part" {
    for_each = var.private_droplet_cloudinit_parts
    content {
      content      = lookup(part.value, "content")
      filename     = lookup(part.value, "filename", null)
      content_type = lookup(part.value, "content_type", null)
      merge_type   = lookup(part.value, "merge_type", null)
    }
  }
}

#--------------------------------------------------------------
# Private Droplet
#--------------------------------------------------------------

resource "digitalocean_droplet" "private" {
  count       = module.private_label.enabled ? var.private_droplet_count : 0
  image       = var.private_droplet_image
  name        = "${coalesce(var.private_droplet_name, module.private_label.id)}-${count.index}"
  region      = digitalocean_vpc.this[0].region
  size        = var.private_droplet_size
  backups     = var.private_droplet_backups
  monitoring  = var.private_droplet_monitoring
  ipv6        = var.private_droplet_ipv6
  vpc_uuid    = digitalocean_vpc.this[0].id
  ssh_keys    = compact(setunion(var.private_droplet_ssh_keys, [module.ssh_key.key_fingerprint]))
  resize_disk = var.private_droplet_resize_disk
  tags        = compact(setunion(var.private_droplet_tags, [for k, v in module.private_label.tags : v if k != "Name"]))
  user_data   = data.cloudinit_config.private.rendered
  volume_ids  = var.private_droplet_volume_ids
}

#--------------------------------------------------------------
# Private Volume
#--------------------------------------------------------------

resource "digitalocean_volume" "private" {
  count                    = module.private_label.enabled && var.private_volume_enabled ? var.private_droplet_count : 0
  region                   = digitalocean_vpc.this[0].region
  name                     = var.private_volume_name
  size                     = var.private_volume_size
  description              = var.private_volume_description
  snapshot_id              = var.private_volume_snapshot_id
  initial_filesystem_type  = var.private_volume_initial_filesystem_type
  initial_filesystem_label = var.private_volume_initial_filesystem_label
  tags                     = compact(setunion(var.private_volume_tags, [for k, v in module.private_label.tags : v if k != "Name"]))
}

resource "digitalocean_volume_attachment" "private" {
  count      = module.private_label.enabled && var.private_volume_enabled ? var.private_droplet_count : 0
  droplet_id = digitalocean_droplet.private[count.index].id
  volume_id  = digitalocean_volume.private[count.index].id
}

#--------------------------------------------------------------
# Private Firewall
#--------------------------------------------------------------

locals {
  private_firewall_inbound_lb_web = var.private_droplet_count == 1 && var.firewall_allow_myip_web ? [
    tomap({
      protocol         = "tcp"
      port_range       = "80"
      source_addresses = "${chomp(data.http.myip[0].body)}/32"
    }),
    tomap({
      protocol         = "tcp"
      port_range       = "443"
      source_addresses = "${chomp(data.http.myip[0].body)}/32"
    }),
    ] : var.private_droplet_count > 1 ? [
    tomap({
      protocol         = "tcp"
      port_range       = "80"
      source_addresses = digitalocean_loadbalancer.public[0].id
    }),
    tomap({
      protocol         = "tcp"
      port_range       = "443"
      source_addresses = digitalocean_loadbalancer.public[0].id
    }),
  ] : []
  private_firewall_inbound_rules = local.private_firewall_inbound_lb_web
}

resource "digitalocean_firewall" "private" {
  count       = module.private_label.enabled ? 1 : 0
  name        = coalesce(var.private_firewall_name, module.private_label.id)
  droplet_ids = digitalocean_droplet.private[*].id
  tags        = var.private_firewall_tags
  dynamic "inbound_rule" {
    for_each = concat(local.private_firewall_inbound_rules, var.private_firewall_inbound_rules)
    content {
      protocol                  = lookup(inbound_rule.value, "protocol", null)
      port_range                = lookup(inbound_rule.value, "port_range", null)
      source_addresses          = lookup(inbound_rule.value, "source_addresses", null) != null ? split(",", lookup(inbound_rule.value, "source_addresses")) : null
      source_droplet_ids        = lookup(inbound_rule.value, "source_droplet_ids", null) != null ? split(",", lookup(inbound_rule.value, "source_droplet_ids")) : null
      source_tags               = lookup(inbound_rule.value, "source_tags", null) != null ? split(",", lookup(inbound_rule.value, "source_tags")) : null
      source_load_balancer_uids = lookup(inbound_rule.value, "source_load_balancer_uids", null) != null ? split(",", lookup(inbound_rule.value, "source_load_balancer_uids")) : null
    }
  }
  dynamic "outbound_rule" {
    for_each = var.private_firewall_outbound_rules
    content {
      protocol                       = lookup(outbound_rule.value, "protocol", null)
      port_range                     = lookup(outbound_rule.value, "port_range", null)
      destination_addresses          = lookup(outbound_rule.value, "destination_addresses", null) != null ? split(",", lookup(outbound_rule.value, "destination_addresses")) : null
      destination_droplet_ids        = lookup(outbound_rule.value, "destination_droplet_ids", null) != null ? split(",", lookup(outbound_rule.value, "destination_droplet_ids")) : null
      destination_tags               = lookup(outbound_rule.value, "destination_tags", null) != null ? split(",", lookup(outbound_rule.value, "destination_tags")) : null
      destination_load_balancer_uids = lookup(outbound_rule.value, "destination_load_balancer_uids", null) != null ? split(",", lookup(outbound_rule.value, "destinattion_load_balancer_uids")) : null
    }
  }
}
