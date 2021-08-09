namespace   = "company"
environment = "dev"
enabled     = true

# ssh-key
generate_ssh_key       = true
ssh_key_name           = "digitalocean"
local_download_enabled = true
local_ssh_key_path     = "~/.ssh"

# vpc
vpc_region      = "sfo3"
vpc_description = "test vpc for igw poc"
vpc_ip_range    = "10.10.10.0/24"

# igw_droplet
igw_droplet_image                = "ubuntu-18-04-x64"
igw_droplet_monitoring           = true
igw_droplet_enable_bastion       = true
igw_droplet_enable_notifications = false

# igw_firewall
igw_firewall_inbound_rules = [
  # # remote ips authorized for ssh access
  # {
  #   protocol         = "tcp"
  #   port_range       = "22"
  #   source_addresses = ["0.0.0.0/0", "::/0"]
  # },
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
private_droplet_image      = "ubuntu-18-04-x64"
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
