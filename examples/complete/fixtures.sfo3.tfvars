namespace   = "hansohn"
environment = "dev"
enabled     = true

# ssh-key
generate_ssh_key       = true
ssh_key_name           = "digitalocean"
local_download_enabled = true
local_ssh_key_path     = "~/.ssh"

# vpc
vpc_region      = "sfo3"
vpc_description = "hansohn dev vpc"
vpc_ip_range    = "10.10.10.0/24"

# igw_droplet
igw_droplet_image                = "ubuntu-22-04-x64"
igw_droplet_size                 = "s-1vcpu-1gb"
igw_droplet_monitoring           = true
igw_droplet_enable_bastion       = true
igw_droplet_enable_notifications = false

# public_loadbalancer
enable_public_lb = false
public_lb_forwarding_rule = [
  {
    entry_port      = 22
    entry_protocol  = "tcp"
    target_port     = 22
    target_protocol = "tcp"
  },
  {
    entry_port      = 443
    entry_protocol  = "https"
    target_port     = 443
    target_protocol = "https"
    tls_passthrough = true
  }
]
public_lb_healthcheck = [{
  protocol = "tcp"
  port     = 22
}]

# public_firewall
firewall_allow_myip_ssh = true
firewall_allow_myip_web = true
public_firewall_inbound_rules = [
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

public_firewall_outbound_rules = [
  {
    protocol              = "icmp"
    destination_addresses = "0.0.0.0/0,::/0"
  },
  {
    protocol              = "tcp"
    port_range            = "all"
    destination_addresses = "0.0.0.0/0,::/0"
  },
  {
    protocol              = "udp"
    port_range            = "all"
    destination_addresses = "0.0.0.0/0,::/0"
  }
]

# private_droplet
private_droplet_count      = 1
private_droplet_image      = "ubuntu-22-04-x64"
private_droplet_size       = "s-1vcpu-1gb"
private_droplet_monitoring = true

# private_firewall
private_firewall_inbound_rules = []
private_firewall_outbound_rules = [
  {
    protocol              = "icmp"
    destination_addresses = "0.0.0.0/0,::/0"
  },
  {
    protocol              = "tcp"
    port_range            = "all"
    destination_addresses = "0.0.0.0/0,::/0"
  },
  {
    protocol              = "udp"
    port_range            = "all"
    destination_addresses = "0.0.0.0/0,::/0"
  }
]
