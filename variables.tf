#--------------------------------------------------------------
# SSH-Key
#--------------------------------------------------------------

variable "ssh_key_name" {
  type        = string
  default     = null
  description = "If ssh_public_key_file and generate_ssh_key are undefined, the name of existing DigitalOcean ssh key to utilize. If ssh_public_key_file or generate_ssh_key are defined, the name to be assoicated with the ssh key in DigitalOcean"
}

variable "ssh_public_key_file" {
  type        = string
  default     = null
  description = "Filename (including path) of existing SSH public key file (e.g. `/path/to/id_rsa.pub`). Confilcts with generate_ssh_key."
}

variable "generate_ssh_key" {
  type        = bool
  default     = false
  description = "If set to `true`, new SSH key pair will be created and `ssh_public_key_file` will be ignored. Conflicts with ssh_public_key_file"
}

variable "algorithm" {
  type        = string
  default     = "RSA"
  description = "SSH key algorithm"
}

variable "rsa_bits" {
  type        = number
  default     = null
  description = "(Optional) When algorithm is 'RSA', the size of the generated RSA key in bits. Defaults to 2048."
}

variable "ecdsa_curve" {
  type        = string
  default     = null
  description = "(Optional) When algorithm is 'ECDSA', the name of the elliptic curve to use. May be any one of 'P224', 'P256', 'P384' or 'P521', with 'P224' as the default."
}

variable "local_download_enabled" {
  type        = bool
  default     = true
  description = "(Optional) If generate_ssh_key enabled, the key pair will be downloaded locally to the ssh_key_path"
}

variable "local_ssh_key_path" {
  type        = string
  default     = null
  description = "Path to local SSH public key directory (e.g. `/secrets`)"
}

#--------------------------------------------------------------
# VPC
#--------------------------------------------------------------

variable "vpc_name" {
  type        = string
  default     = null
  description = "(Required) A name for the VPC. Must be unique and contain alphanumeric characters, dashes, and periods only."
}

variable "vpc_region" {
  type        = string
  default     = null
  description = "(Required) The DigitalOcean region slug for the VPC's location."
}

variable "vpc_description" {
  type        = string
  default     = null
  description = "(Optional) A free-form text field up to a limit of 255 characters to describe the VPC."
}

variable "vpc_ip_range" {
  type        = string
  default     = null
  description = "(Optional) The range of IP addresses for the VPC in CIDR notation. Network ranges cannot overlap with other networks in the same account and must be in range of private addresses as defined in RFC1918. It may not be larger than /16 or smaller than /24."
}

#--------------------------------------------------------------
# Internet Gateway Droplet
#--------------------------------------------------------------

variable "igw_droplet_image" {
  type        = string
  default     = null
  description = "(Required) The Droplet image ID or slug."
}

variable "igw_droplet_name" {
  type        = string
  default     = null
  description = "(Required) The Droplet name."
}

variable "igw_droplet_size" {
  type        = string
  default     = "s-1vcpu-1gb"
  description = "(Required) The unique slug that indentifies the type of Droplet."
}

variable "igw_droplet_backups" {
  type        = bool
  default     = null
  description = "(Optional) Boolean controlling if backups are made. Defaults to false."
}

variable "igw_droplet_monitoring" {
  type        = bool
  default     = true
  description = "(Optional) Boolean controlling whether monitoring agent is installed. Defaults to false."
}

variable "igw_droplet_ipv6" {
  type        = bool
  default     = null
  description = "(Optional) Boolean controlling if IPv6 is enabled. Defaults to false."
}

variable "igw_droplet_vpc_uuid" {
  type        = string
  default     = null
  description = "(Optional) The ID of the VPC where the Droplet will be located."
}

variable "igw_droplet_ssh_keys" {
  type        = list(string)
  default     = null
  description = "(Optional) A list of SSH IDs or fingerprints to enable in the format [12345, 123456]."
}

variable "igw_droplet_resize_disk" {
  type        = bool
  default     = null
  description = "(Optional) Boolean controlling whether to increase the disk size when resizing a Droplet. It defaults to true. When set to false, only the Droplet's RAM and CPU will be resized. Increasing a Droplet's disk size is a permanent change. Increasing only RAM and CPU is reversible."
}

variable "igw_droplet_tags" {
  type        = list(string)
  default     = null
  description = "(Optional) A list of the tags to be applied to this Droplet."
}

variable "igw_droplet_user_data" {
  type        = string
  default     = null
  description = "(Optional) - A string of the desired User Data for the Droplet."
}

variable "igw_droplet_volume_ids" {
  type        = list(string)
  default     = null
  description = "(Optional) - A list of the IDs of each block storage volume to be attached to the Droplet."
}

variable "igw_droplet_enable_bastion" {
  type        = bool
  default     = false
  description = "(Optional) Boolean controlling whether to enable bastion ssh feature on droplet"
}

variable "igw_droplet_enable_notifications" {
  type        = bool
  default     = false
  description = "(Optional) Boolean controlling whether to enable slack notifications. Currently this feature only applies to bastion fail2ban sshd jail notifications."
}

#--------------------------------------------------------------
# Slack Notifications
#--------------------------------------------------------------

variable "slack_channel" {
  type        = string
  default     = ""
  description = "(Optional) The name of the channel to be used as the destination for webhook messages."
}

variable "slack_username" {
  type        = string
  default     = ""
  description = "(Optional) Slack username to post on behalf of for notifications."
}

variable "slack_icon" {
  type        = string
  default     = ""
  description = "(Optional) Slack emoji icon to used for notifications."
}

variable "slack_webhook_url" {
  type        = string
  default     = ""
  description = "(Optional) The Incoming Webhook URL"
}

#--------------------------------------------------------------
# Private Volume
#--------------------------------------------------------------

variable "igw_volume_enabled" {
  type        = bool
  default     = false
  description = "Boolean controlling whether a volume will be created and attached to the internet gateway instnace"
}

variable "igw_volume_name" {
  type        = string
  default     = null
  description = "(Required) A name for the block storage volume. Must be lowercase and be composed only of numbers, letters and '-', up to a limit of 64 characters."
}

variable "igw_volume_size" {
  type        = number
  default     = null
  description = "(Required) The size of the block storage volume in GiB. If updated, can only be expanded."
}

variable "igw_volume_description" {
  type        = string
  default     = null
  description = "(Optional) A free-form text field up to a limit of 1024 bytes to describe a block storage volume."
}

variable "igw_volume_snapshot_id" {
  type        = string
  default     = null
  description = "(Optional) The ID of an existing volume snapshot from which the new volume will be created. If supplied, the region and size will be limitied on creation to that of the referenced snapshot"
}

variable "igw_volume_initial_filesystem_type" {
  type        = string
  default     = null
  description = "(Optional) Initial filesystem type (xfs or ext4) for the block storage volume."
}

variable "igw_volume_initial_filesystem_label" {
  type        = string
  default     = null
  description = "(Optional) Initial filesystem label for the block storage volume."
}

variable "igw_volume_tags" {
  type        = list(string)
  default     = null
  description = "(Optional) A list of the tags to be applied to this Volume."
}

#--------------------------------------------------------------
# Internet Gateway Firewall
#--------------------------------------------------------------

variable "igw_firewall_name" {
  type        = string
  default     = null
  description = "(Required) The Firewall name"
}

variable "igw_firewall_inbound_rules" {
  type = list(any)
  default = [
    {
      protocol         = "tcp"
      port_range       = "22"
      source_addresses = "0.0.0.0/0, ::/0"
    }
  ]
  description = "(Optional) The inbound access rule block for the Firewall."
}

variable "igw_firewall_outbound_rules" {
  type = list(any)
  default = [
    {
      protocol              = "icmp"
      destination_addresses = "0.0.0.0/0, ::/0"
    },
    {
      protocol              = "tcp"
      port_range            = "1-65535"
      destination_addresses = "0.0.0.0/0, ::/0"
    },
    {
      protocol              = "udp"
      port_range            = "1-65535"
      destination_addresses = "0.0.0.0/0, ::/0"
    }
  ]
  description = "(Optional) The outbound access rule block for the Firewall."
}

#--------------------------------------------------------------
# Private Droplet
#--------------------------------------------------------------

variable "private_droplet_count" {
  type        = number
  default     = 1
  description = "(Optional) Number of private droplet instances to create. Defauts to 1."
}

variable "private_droplet_image" {
  type        = string
  default     = null
  description = "(Required) The Droplet image ID or slug."
}

variable "private_droplet_name" {
  type        = string
  default     = null
  description = "(Required) The Droplet name."
}

variable "private_droplet_size" {
  type        = string
  default     = "s-1vcpu-1gb"
  description = "(Required) The unique slug that indentifies the type of Droplet."
}

variable "private_droplet_backups" {
  type        = bool
  default     = null
  description = "(Optional) Boolean controlling if backups are made. Defaults to false."
}

variable "private_droplet_monitoring" {
  type        = bool
  default     = null
  description = "(Optional) Boolean controlling whether monitoring agent is installed. Defaults to false."
}

variable "private_droplet_ipv6" {
  type        = bool
  default     = null
  description = "(Optional) Boolean controlling if IPv6 is enabled. Defaults to false."
}

variable "private_droplet_vpc_uuid" {
  type        = string
  default     = null
  description = "(Optional) The ID of the VPC where the Droplet will be located."
}

variable "private_droplet_ssh_keys" {
  type        = list(string)
  default     = null
  description = "(Optional) A list of SSH IDs or fingerprints to enable in the format [12345, 123456]."
}

variable "private_droplet_resize_disk" {
  type        = bool
  default     = null
  description = "(Optional) Boolean controlling whether to increase the disk size when resizing a Droplet. It defaults to true. When set to false, only the Droplet's RAM and CPU will be resized. Increasing a Droplet's disk size is a permanent change. Increasing only RAM and CPU is reversible."
}

variable "private_droplet_tags" {
  type        = list(string)
  default     = null
  description = "(Optional) A list of the tags to be applied to this Droplet."
}

variable "private_droplet_user_data" {
  type        = string
  default     = null
  description = "(Optional) - A string of the desired User Data for the Droplet."
}

variable "private_droplet_volume_ids" {
  type        = list(string)
  default     = null
  description = "(Optional) - A list of the IDs of each block storage volume to be attached to the Droplet."
}

#--------------------------------------------------------------
# Private Volume
#--------------------------------------------------------------

variable "private_volume_enabled" {
  type        = bool
  default     = false
  description = "Boolean controlling whether a volume will be created and attached to the private instnace(s)"
}

variable "private_volume_name" {
  type        = string
  default     = null
  description = "(Required) A name for the block storage volume. Must be lowercase and be composed only of numbers, letters and '-', up to a limit of 64 characters."
}

variable "private_volume_size" {
  type        = number
  default     = null
  description = "(Required) The size of the block storage volume in GiB. If updated, can only be expanded."
}

variable "private_volume_description" {
  type        = string
  default     = null
  description = "(Optional) A free-form text field up to a limit of 1024 bytes to describe a block storage volume."
}

variable "private_volume_snapshot_id" {
  type        = string
  default     = null
  description = "(Optional) The ID of an existing volume snapshot from which the new volume will be created. If supplied, the region and size will be limitied on creation to that of the referenced snapshot"
}

variable "private_volume_initial_filesystem_type" {
  type        = string
  default     = null
  description = "(Optional) Initial filesystem type (xfs or ext4) for the block storage volume."
}

variable "private_volume_initial_filesystem_label" {
  type        = string
  default     = null
  description = "(Optional) Initial filesystem label for the block storage volume."
}

variable "private_volume_tags" {
  type        = list(string)
  default     = null
  description = "(Optional) A list of the tags to be applied to this Volume."
}

#--------------------------------------------------------------
# Private Firewall
#--------------------------------------------------------------

variable "private_firewall_name" {
  type        = string
  default     = null
  description = "(Required) The Firewall name"
}

variable "private_firewall_inbound_rules" {
  type        = list(any)
  default     = []
  description = "(Optional) The inbound access rule block for the Firewall."
}

variable "private_firewall_outbound_rules" {
  type        = list(any)
  default     = []
  description = "(Optional) The outbound access rule block for the Firewall."
}
