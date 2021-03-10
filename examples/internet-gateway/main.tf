terraform {
  required_providers {
    digitalocean = "2.1.0"
  }
}

provider "digitalocean" {
  token = var.do_token
}

module "igw" {
  source = "../../"

  # labeling
  namespace = "company"
  environment = "dev"
  enabled = true

  # ssh-key
  generate_ssh_key = var.generate_ssh_key
  ssh_key_name = var.ssh_key_name
  ssh_public_key_file = var.ssh_public_key_file
  local_download_enabled = true
  local_ssh_key_path = "~/.ssh"

  # vpc
  vpc_region = "sfo3"
  vpc_description = "test vpc for igw poc"
  vpc_ip_range = "10.10.10.0/24"

  # igw_droplet
  igw_droplet_image = "ubuntu-18-04-x64"
  igw_droplet_monitoring = true
  igw_droplet_enable_bastion = var.igw_droplet_enable_bastion
  igw_droplet_enable_notifications = var.igw_droplet_enable_notifications

  # igw_firewall
  igw_firewall_inbound_rules = concat(
    [
      for ip in var.remote_access_ips:
      {
        protocol         = "tcp"
        port_range       = "22"
        source_addresses = ip
      }
    ],
    [
      {
        protocol    = "icmp"
        source_tags = "private"
      },
      {
        protocol    = "tcp"
        port_range  = "all"
        source_tags = "private"
      },
      {
        protocol    = "udp"
        port_range  = "all"
        source_tags = "private"
      }
    ]
  )
  igw_firewall_outbound_rules = [
    {
      protocol              = "icmp"
      destination_addresses = "0.0.0.0/0, ::/0"
    },
    {
      protocol              = "tcp"
      port_range            = "all"
      destination_addresses = "0.0.0.0/0, ::/0"
    },
    {
      protocol              = "udp"
      port_range            = "all"
      destination_addresses = "0.0.0.0/0, ::/0"
    }
  ]

  # private_droplet
  private_droplet_image = "ubuntu-18-04-x64"
  private_droplet_monitoring = true

  # private_firewall
  private_firewall_inbound_rules = [
    {
      protocol    = "tcp"
      port_range  = "22"
      source_tags = "igw"
    }
  ]
  private_firewall_outbound_rules = [
    {
      protocol              = "icmp"
      destination_addresses = "0.0.0.0/0, ::/0"
    },
    {
      protocol              = "tcp"
      port_range            = "all"
      destination_addresses = "0.0.0.0/0, ::/0"
    },
    {
      protocol              = "udp"
      port_range            = "all"
      destination_addresses = "0.0.0.0/0, ::/0"
    }
  ]
  
  # slack notifications
  slack_channel = var.slack_channel
  slack_username = var.slack_username
  slack_icon = var.slack_icon
  slack_webhook_url = var.slack_webhook_url
}
