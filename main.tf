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
# Internet Gateway Droplet
#--------------------------------------------------------------

locals {
  igw_droplet_user_data = templatefile(
    "${path.module}/templates/igw.sh",
    {
      vpc_network_prefix   = digitalocean_vpc.this[0].ip_range,
      enable_bastion       = var.igw_droplet_enable_bastion,
      enable_notifications = var.igw_droplet_enable_notifications,
      slack_channel        = var.slack_channel,
      slack_username       = var.slack_username,
      slack_icon           = var.slack_icon,
      slack_webhook_url    = var.slack_webhook_url
    }
  )
}

resource "digitalocean_droplet" "igw" {
  count              = module.igw_label.enabled ? 1 : 0
  image              = var.igw_droplet_image
  name               = var.igw_droplet_name != null ? var.igw_droplet_name : module.igw_label.id
  region             = digitalocean_vpc.this[0].region
  size               = var.igw_droplet_size
  backups            = var.igw_droplet_backups
  monitoring         = var.igw_droplet_monitoring
  ipv6               = var.igw_droplet_ipv6
  vpc_uuid           = digitalocean_vpc.this[0].id
  private_networking = true
  ssh_keys           = compact(setunion(var.igw_droplet_ssh_keys, [module.ssh_key.key_fingerprint]))
  resize_disk        = var.igw_droplet_resize_disk
  tags               = compact(setunion(var.igw_droplet_tags, [for k, v in module.igw_label.tags : v if k != "Name"]))
  user_data          = var.igw_droplet_user_data != null ? var.igw_droplet_user_data : local.igw_droplet_user_data
  volume_ids         = var.igw_droplet_volume_ids
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

resource "digitalocean_firewall" "igw" {
  count       = module.igw_label.enabled ? 1 : 0
  name        = var.igw_firewall_name != null ? var.igw_firewall_name : join(module.igw_label.delimiter, compact(concat(["firewall"], module.igw_label.attributes)))
  droplet_ids = digitalocean_droplet.igw[*].id
  tags        = compact(setunion(var.igw_volume_tags, [for k, v in module.igw_label.tags : v if k != "Name"]))
  dynamic "inbound_rule" {
    for_each = var.igw_firewall_inbound_rules
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
# Private Droplet
#--------------------------------------------------------------

locals {
  private_droplet_user_data = templatefile(
    "${path.module}/templates/private.sh",
    { igw_private_ip = digitalocean_droplet.igw[0].ipv4_address_private }
  )
}

resource "digitalocean_droplet" "private" {
  count              = module.private_label.enabled ? var.private_droplet_count : 0
  image              = var.private_droplet_image
  name               = var.private_droplet_name != null ? var.private_droplet_name : module.private_label.id
  region             = digitalocean_vpc.this[0].region
  size               = var.private_droplet_size
  backups            = var.private_droplet_backups
  monitoring         = var.private_droplet_monitoring
  ipv6               = var.private_droplet_ipv6
  vpc_uuid           = digitalocean_vpc.this[0].id
  private_networking = true
  ssh_keys           = compact(setunion(var.private_droplet_ssh_keys, [module.ssh_key.key_fingerprint]))
  resize_disk        = var.private_droplet_resize_disk
  tags               = compact(setunion(var.private_droplet_tags, [for k, v in module.private_label.tags : v if k != "Name"]))
  user_data          = var.private_droplet_user_data != null ? var.private_droplet_user_data : local.private_droplet_user_data
  volume_ids         = var.private_droplet_volume_ids
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
  name        = var.private_firewall_name != null ? var.private_firewall_name : join(module.private_label.delimiter, compact(concat(["firewall"], module.private_label.attributes)))
  droplet_ids = digitalocean_droplet.private[*].id
  tags        = compact(setunion(var.private_firewall_tags, [for k, v in module.private_label.tags : v if k != "Name"]))
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
