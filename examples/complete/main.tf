provider "digitalocean" {
  token = var.do_token
}

module "igw" {
  source  = "../../"
  context = module.this.context

  # ssh-key
  generate_ssh_key       = var.generate_ssh_key
  ssh_key_name           = var.ssh_key_name
  ssh_public_key_file    = var.ssh_public_key_file
  local_download_enabled = var.local_download_enabled
  local_ssh_key_path     = var.local_ssh_key_path

  # vpc
  vpc_region      = var.vpc_region
  vpc_description = var.vpc_description
  vpc_ip_range    = var.vpc_ip_range

  # igw_droplet
  igw_droplet_image                = var.igw_droplet_image
  igw_droplet_monitoring           = var.igw_droplet_monitoring
  igw_droplet_enable_bastion       = var.igw_droplet_enable_bastion
  igw_droplet_enable_notifications = var.igw_droplet_enable_notifications

  # igw_firewall
  igw_allow_myip_ssh          = var.igw_allow_myip_ssh
  igw_firewall_inbound_rules  = var.igw_firewall_inbound_rules
  igw_firewall_outbound_rules = var.igw_firewall_outbound_rules

  # private_droplet
  private_droplet_image      = var.private_droplet_image
  private_droplet_monitoring = var.private_droplet_monitoring

  # private_firewall
  private_firewall_inbound_rules  = var.private_firewall_inbound_rules
  private_firewall_outbound_rules = var.private_firewall_outbound_rules

  # slack notifications
  slack_channel     = var.slack_channel
  slack_username    = var.slack_username
  slack_icon        = var.slack_icon
  slack_webhook_url = var.slack_webhook_url
}
