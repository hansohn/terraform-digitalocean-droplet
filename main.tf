#--------------------------------------------------------------
# Labeling
#--------------------------------------------------------------

module "igw_label" {
  source     = "cloudposse/label/null"
  version    = "0.25.0"
  attributes = compact(concat(module.this.attributes, ["igw"]))
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

resource "digitalocean_floating_ip" "this" {
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
  ip_address = digitalocean_floating_ip.this[0].ip_address
  droplet_id = digitalocean_droplet.igw[0].id
}

#--------------------------------------------------------------
# Internet Gateway Firewall
#--------------------------------------------------------------

data "http" "myip" {
  count = var.igw_allow_myip_ssh ? 1 : 0
  url   = "https://ipinfo.io/ip/"
}

locals {
  igw_firewall_inbound_myip_ssh = var.igw_allow_myip_ssh ? [
    tomap({
      protocol         = "tcp"
      port_range       = "22"
      source_addresses = "${chomp(data.http.myip[0].body)}/32"
    })
  ] : []
}

resource "digitalocean_firewall" "igw" {
  count       = module.igw_label.enabled ? 1 : 0
  name        = coalesce(var.igw_firewall_name, module.igw_label.id)
  droplet_ids = digitalocean_droplet.igw[*].id
  tags        = var.igw_firewall_tags
  dynamic "inbound_rule" {
    for_each = concat(local.igw_firewall_inbound_myip_ssh, var.igw_firewall_inbound_rules)
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
    for_each = var.igw_firewall_outbound_rules
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
# Private Gateway Cloud-Init
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
  name        = coalesce(var.private_droplet_name, module.private_label.id)
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

resource "digitalocean_firewall" "private" {
  count       = module.private_label.enabled ? 1 : 0
  name        = coalesce(var.private_firewall_name, module.private_label.id)
  droplet_ids = digitalocean_droplet.private[*].id
  tags        = var.private_firewall_tags
  dynamic "inbound_rule" {
    for_each = var.private_firewall_inbound_rules
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
