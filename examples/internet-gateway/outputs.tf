#--------------------------------------------------------------
# VPC
#--------------------------------------------------------------

output "vpc_id" {
  value = module.igw.vpc_id
  description = "The unique identifier for the VPC."
}

output "vpc_urn" {
  value = module.igw.vpc_urn
  description = "The uniform resource name (URN) for the VPC."
}

output "vpc_default" {
  value = module.igw.vpc_default
  description = "A boolean indicating whether or not the VPC is the default one for the region."
}

output "vpc_created_at" {
  value = module.igw.vpc_created_at
  description = "The date and time of when the VPC was created."
}

#--------------------------------------------------------------
# Floating Ip
#--------------------------------------------------------------

output "floating_ip_address" {
  value = module.igw.floating_ip_address
  description = "The IP Address of the resource"
}

output "floating_ip_urn" {
  value = module.igw.floating_ip_urn
  description = "The uniform resource name of the floating ip"
}

#--------------------------------------------------------------
# Internet Gateway Droplet
#--------------------------------------------------------------

output "igw_droplet_id" {
  value = module.igw.igw_droplet_id
  description = "The ID of the Droplet"
}

output "igw_droplet_urn" {
  value = module.igw.igw_droplet_urn
  description = "The uniform resource name of the Droplet"
}

output "igw_droplet_name" {
  value = module.igw.igw_droplet_name
  description = "The name of the Droplet"
}

output "igw_droplet_region" {
  value = module.igw.igw_droplet_region
  description = "The region of the Droplet"
}

output "igw_droplet_image" {
  value = module.igw.igw_droplet_image
  description = "The image of the Droplet"
}

output "igw_droplet_ipv6" {
  value = module.igw.igw_droplet_ipv6
  description = "Is IPv6 enabled"
}

output "igw_droplet_ipv6_address" {
  value = module.igw.igw_droplet_ipv6_address
  description = "The IPv6 address"
}

output "igw_droplet_ipv4_address" {
  value = module.igw.igw_droplet_ipv4_address
  description = "The IPv4 address"
}

output "igw_droplet_ipv4_address_private" {
  value = module.igw.igw_droplet_ipv4_address_private
  description = "The IPv4 address"
}

output "igw_droplet_locked" {
  value = module.igw.igw_droplet_locked
  description = "The IPv4 address"
}

output "igw_droplet_private_networking" {
  value = module.igw.igw_droplet_private_networking
  description = "Is private networking enabled"
}

output "igw_droplet_price_hourly" {
  value = module.igw.igw_droplet_price_hourly
  description = "Droplet hourly price"
}

output "igw_droplet_price_monthly" {
  value = module.igw.igw_droplet_price_monthly
  description = "Droplet monthly price"
}

output "igw_droplet_size" {
  value = module.igw.igw_droplet_size
  description = "The instance size"
}

output "igw_droplet_disk" {
  value = module.igw.igw_droplet_disk
  description = "The size of the instance's disk in GB"
}

output "igw_droplet_vcpus" {
  value = module.igw.igw_droplet_vcpus
  description = "The number of the instance's virtual CPUs"
}

output "igw_droplet_status" {
  value = module.igw.igw_droplet_status
  description = "The status of the Droplet"
}

output "igw_droplet_tags" {
  value = module.igw.igw_droplet_tags
  description = "The tags associated with the Droplet"
}

output "igw_droplet_volume_ids" {
  value = module.igw.igw_droplet_volume_ids
  description = "A list of the attached block storage volumes"
}

#--------------------------------------------------------------
# Internet Gateway Volume
#--------------------------------------------------------------

output "igw_volume_id" {
  value = module.igw.igw_volume_id
  description = "The unique identifier for the volume."
}

output "igw_volume_urn" {
  value = module.igw.igw_volume_urn
  description = "The uniform resource name for the volume."
}

output "igw_volume_name" {
  value = module.igw.igw_volume_name
  description = "Name of the volume."
}

output "igw_volume_description" {
  value = module.igw.igw_volume_description
  description = "Description of the volume."
}

output "igw_volume_tags" {
  value = module.igw.igw_volume_tags
  description = "List of applied tags to the volume."
}

output "igw_volume_region" {
  value = module.igw.igw_volume_region
  description = "The region that the volume is created in."
}

output "igw_volume_droplet_ids" {
  value = module.igw.igw_volume_droplet_ids
  description = "A list of associated droplet ids."
}

output "igw_volume_snapshot_id" {
  value = module.igw.igw_volume_snapshot_id
  description = "The ID of the existing volume snapshot from which this volume was created from."
}

output "igw_volume_filesystem_type" {
  value = module.igw.igw_volume_filesystem_type
  description = "Filesystem type (xfs or ext4) for the block storage volume."
}

output "igw_volume_filesystem_label" {
  value = module.igw.igw_volume_filesystem_label
  description = "Filesystem label for the block storage volume."
}

output "igw_volume_initial_filesystem_type" {
  value = module.igw.igw_volume_initial_filesystem_type
  description = "Filesystem type (xfs or ext4) for the block storage volume when it was first created."
}

output "igw_volume_initial_filesystem_label" {
  value = module.igw.igw_volume_initial_filesystem_label
  description = "Filesystem label for the block storage volume when it was first created."
}

#--------------------------------------------------------------
# Internet Gateway Firewall
#--------------------------------------------------------------

output "igw_firewall_id" {
  value = module.igw.igw_firewall_id
  description = "A unique ID that can be used to identify and reference a Firewall."
}

output "igw_firewall_status" {
  value = module.igw.igw_firewall_status
  description = "A status string indicating the current state of the Firewall. This can be 'waiting', 'succeeded', or 'failed'."
}

output "igw_firewall_created_at" {
  value = module.igw.igw_firewall_created_at
  description = "A time value given in ISO8601 combined date and time format that represents when the Firewall was created."
}

output "igw_firewall_pending_changes" {
  value = module.igw.igw_firewall_pending_changes
  description = "An list of object containing the fields, 'droplet_id', 'removing', and 'status'. It is provided to detail exactly which Droplets are having their security policies updated. When empty, all changes have been successfully applied."
}

output "igw_firewall_name" {
  value = module.igw.igw_firewall_name
  description = "The name of the Firewall."
}

output "igw_firewall_droplet_ids" {
  value = module.igw.igw_firewall_droplet_ids
  description = "The list of the IDs of the Droplets assigned to the Firewall."
}

output "igw_firewall_tags" {
  value = module.igw.igw_firewall_tags
  description = "The names of the Tags assigned to the Firewall."
}

# output "igw_firewall_inbound_rules" {
#   value = module.igw.igw_firewall_inbound_rules
#   description = "The inbound access rule block for the Firewall."
# }
# 
# output "igw_firewall_outbound_rules" {
#   value = module.igw.igw_firewall_outbound_rules
#   description = "The outbound access rule block for the Firewall."
# }

#--------------------------------------------------------------
# Private Droplet(s)
#--------------------------------------------------------------

output "private_droplet_id" {
  value = module.igw.private_droplet_id
  description = "The ID of the Droplet"
}

output "private_droplet_urn" {
  value = module.igw.private_droplet_urn
  description = "The uniform resource name of the Droplet"
}

output "private_droplet_name" {
  value = module.igw.private_droplet_name
  description = "The name of the Droplet"
}

output "private_droplet_region" {
  value = module.igw.private_droplet_region
  description = "The region of the Droplet"
}

output "private_droplet_image" {
  value = module.igw.private_droplet_image
  description = "The image of the Droplet"
}

output "private_droplet_ipv6" {
  value = module.igw.private_droplet_ipv6
  description = "Is IPv6 enabled"
}

output "private_droplet_ipv6_address" {
  value = module.igw.private_droplet_ipv6_address
  description = "The IPv6 address"
}

output "private_droplet_ipv4_address" {
  value = module.igw.private_droplet_ipv4_address
  description = "The IPv4 address"
}

output "private_droplet_ipv4_address_private" {
  value = module.igw.private_droplet_ipv4_address_private
  description = "The IPv4 address"
}

output "private_droplet_locked" {
  value = module.igw.private_droplet_locked
  description = "The IPv4 address"
}

output "private_droplet_private_networking" {
  value = module.igw.private_droplet_private_networking
  description = "Is private networking enabled"
}

output "private_droplet_price_hourly" {
  value = module.igw.private_droplet_price_hourly
  description = "Droplet hourly price"
}

output "private_droplet_price_monthly" {
  value = module.igw.private_droplet_price_monthly
  description = "Droplet monthly price"
}

output "private_droplet_size" {
  value = module.igw.private_droplet_size
  description = "The instance size"
}

output "private_droplet_disk" {
  value = module.igw.private_droplet_disk
  description = "The size of the instance's disk in GB"
}

output "private_droplet_vcpus" {
  value = module.igw.private_droplet_vcpus
  description = "The number of the instance's virtual CPUs"
}

output "private_droplet_status" {
  value = module.igw.private_droplet_status
  description = "The status of the Droplet"
}

output "private_droplet_tags" {
  value = module.igw.private_droplet_tags
  description = "The tags associated with the Droplet"
}

output "private_droplet_volume_ids" {
  value = module.igw.private_droplet_volume_ids
  description = "A list of the attached block storage volumes"
}

#--------------------------------------------------------------
# Private Volume
#--------------------------------------------------------------

output "private_volume_id" {
  value = module.igw.private_volume_id
  description = "The unique identifier for the volume."
}

output "private_volume_urn" {
  value = module.igw.private_volume_urn
  description = "The uniform resource name for the volume."
}

output "private_volume_name" {
  value = module.igw.private_volume_name
  description = "Name of the volume."
}

output "private_volume_description" {
  value = module.igw.private_volume_description
  description = "Description of the volume."
}

output "private_volume_tags" {
  value = module.igw.private_volume_tags
  description = "List of applied tags to the volume."
}

output "private_volume_region" {
  value = module.igw.private_volume_region
  description = "The region that the volume is created in."
}

output "private_volume_droplet_ids" {
  value = module.igw.private_volume_droplet_ids
  description = "A list of associated droplet ids."
}

output "private_volume_snapshot_id" {
  value = module.igw.private_volume_snapshot_id
  description = "The ID of the existing volume snapshot from which this volume was created from."
}

output "private_volume_filesystem_type" {
  value = module.igw.private_volume_filesystem_type
  description = "Filesystem type (xfs or ext4) for the block storage volume."
}

output "private_volume_filesystem_label" {
  value = module.igw.private_volume_filesystem_label
  description = "Filesystem label for the block storage volume."
}

output "private_volume_initial_filesystem_type" {
  value = module.igw.private_volume_initial_filesystem_type
  description = "Filesystem type (xfs or ext4) for the block storage volume when it was first created."
}

output "private_volume_initial_filesystem_label" {
  value = module.igw.private_volume_initial_filesystem_label
  description = "Filesystem label for the block storage volume when it was first created."
}

#--------------------------------------------------------------
# Private Droplet Firewall
#--------------------------------------------------------------

output "private_firewall_id" {
  value = module.igw.private_firewall_id
  description = "A unique ID that can be used to identify and reference a Firewall."
}

output "private_firewall_status" {
  value = module.igw.private_firewall_status
  description = "A status string indicating the current state of the Firewall. This can be 'waiting', 'succeeded', or 'failed'."
}

output "private_firewall_created_at" {
  value = module.igw.private_firewall_created_at
  description = "A time value given in ISO8601 combined date and time format that represents when the Firewall was created."
}

output "private_firewall_pending_changes" {
  value = module.igw.private_firewall_pending_changes
  description = "An list of object containing the fields, 'droplet_id', 'removing', and 'status'. It is provided to detail exactly which Droplets are having their security policies updated. When empty, all changes have been successfully applied."
}

output "private_firewall_name" {
  value = module.igw.private_firewall_name
  description = "The name of the Firewall."
}

output "private_firewall_droplet_ids" {
  value = module.igw.private_firewall_droplet_ids
  description = "The list of the IDs of the Droplets assigned to the Firewall."
}

output "private_firewall_tags" {
  value = module.igw.private_firewall_tags
  description = "The names of the Tags assigned to the Firewall."
}

# output "private_firewall_inbound_rules" {
#   value = module.igw.private_firewall_inbound_rules
#   description = "The inbound access rule block for the Firewall."
# }
# 
# output "private_firewall_outbound_rules" {
#   value = module.igw.private_firewall_outbound_rules
#   description = "The outbound access rule block for the Firewall."
# }
