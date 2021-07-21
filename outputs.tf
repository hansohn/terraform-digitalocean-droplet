#--------------------------------------------------------------
# VPC
#--------------------------------------------------------------

output "vpc_id" {
  value       = element(concat(digitalocean_vpc.this.*.id, [""]), 0)
  description = "The unique identifier for the VPC."
}

output "vpc_urn" {
  value       = element(concat(digitalocean_vpc.this.*.urn, [""]), 0)
  description = "The uniform resource name (URN) for the VPC."
}

output "vpc_default" {
  value       = element(concat(digitalocean_vpc.this.*.default, [""]), 0)
  description = "A boolean indicating whether or not the VPC is the default one for the region."
}

output "vpc_created_at" {
  value       = element(concat(digitalocean_vpc.this.*.created_at, [""]), 0)
  description = "The date and time of when the VPC was created."
}

#--------------------------------------------------------------
# Floating Ip
#--------------------------------------------------------------

output "floating_ip_address" {
  value       = element(concat(digitalocean_floating_ip.this.*.ip_address, [""]), 0)
  description = "The IP Address of the resource"
}

output "floating_ip_urn" {
  value       = element(concat(digitalocean_floating_ip.this.*.urn, [""]), 0)
  description = "The uniform resource name of the floating ip"
}

#--------------------------------------------------------------
# Internet Gateway Droplet
#--------------------------------------------------------------

output "igw_droplet_id" {
  value       = element(concat(digitalocean_droplet.igw.*.id, [""]), 0)
  description = "The ID of the Droplet"
}

output "igw_droplet_urn" {
  value       = element(concat(digitalocean_droplet.igw.*.urn, [""]), 0)
  description = "The uniform resource name of the Droplet"
}

output "igw_droplet_name" {
  value       = element(concat(digitalocean_droplet.igw.*.name, [""]), 0)
  description = "The name of the Droplet"
}

output "igw_droplet_region" {
  value       = element(concat(digitalocean_droplet.igw.*.region, [""]), 0)
  description = "The region of the Droplet"
}

output "igw_droplet_image" {
  value       = element(concat(digitalocean_droplet.igw.*.image, [""]), 0)
  description = "The image of the Droplet"
}

output "igw_droplet_ipv6" {
  value       = element(concat(digitalocean_droplet.igw.*.ipv6, [""]), 0)
  description = "Is IPv6 enabled"
}

output "igw_droplet_ipv6_address" {
  value       = element(concat(digitalocean_droplet.igw.*.ipv6_address, [""]), 0)
  description = "The IPv6 address"
}

output "igw_droplet_ipv4_address" {
  value       = element(concat(digitalocean_droplet.igw.*.ipv4_address, [""]), 0)
  description = "The IPv4 address"
}

output "igw_droplet_ipv4_address_private" {
  value       = element(concat(digitalocean_droplet.igw.*.ipv4_address_private, [""]), 0)
  description = "The IPv4 address"
}

output "igw_droplet_locked" {
  value       = element(concat(digitalocean_droplet.igw.*.locked, [""]), 0)
  description = "The IPv4 address"
}

output "igw_droplet_private_networking" {
  value       = element(concat(digitalocean_droplet.igw.*.private_networking, [""]), 0)
  description = "Is private networking enabled"
}

output "igw_droplet_price_hourly" {
  value       = element(concat(digitalocean_droplet.igw.*.price_hourly, [""]), 0)
  description = "Droplet hourly price"
}

output "igw_droplet_price_monthly" {
  value       = element(concat(digitalocean_droplet.igw.*.price_monthly, [""]), 0)
  description = "Droplet monthly price"
}

output "igw_droplet_size" {
  value       = element(concat(digitalocean_droplet.igw.*.size, [""]), 0)
  description = "The instance size"
}

output "igw_droplet_disk" {
  value       = element(concat(digitalocean_droplet.igw.*.disk, [""]), 0)
  description = "The size of the instance's disk in GB"
}

output "igw_droplet_vcpus" {
  value       = element(concat(digitalocean_droplet.igw.*.vcpus, [""]), 0)
  description = "The number of the instance's virtual CPUs"
}

output "igw_droplet_status" {
  value       = element(concat(digitalocean_droplet.igw.*.status, [""]), 0)
  description = "The status of the Droplet"
}

output "igw_droplet_tags" {
  value       = element(concat(digitalocean_droplet.igw.*.tags, [""]), 0)
  description = "The tags associated with the Droplet"
}

output "igw_droplet_volume_ids" {
  value       = element(concat(digitalocean_droplet.igw.*.volume_ids, [""]), 0)
  description = "A list of the attached block storage volumes"
}

#--------------------------------------------------------------
# Internet Gateway Volume
#--------------------------------------------------------------

output "igw_volume_id" {
  value       = element(concat(digitalocean_volume.igw.*.id, [""]), 0)
  description = "The unique identifier for the volume."
}

output "igw_volume_urn" {
  value       = element(concat(digitalocean_volume.igw.*.urn, [""]), 0)
  description = "The uniform resource name for the volume."
}

output "igw_volume_name" {
  value       = element(concat(digitalocean_volume.igw.*.name, [""]), 0)
  description = "Name of the volume."
}

output "igw_volume_description" {
  value       = element(concat(digitalocean_volume.igw.*.description, [""]), 0)
  description = "Description of the volume."
}

output "igw_volume_tags" {
  value       = element(concat(digitalocean_volume.igw.*.tags, [""]), 0)
  description = "List of applied tags to the volume."
}

output "igw_volume_region" {
  value       = element(concat(digitalocean_volume.igw.*.region, [""]), 0)
  description = "The region that the volume is created in."
}

output "igw_volume_droplet_ids" {
  value       = element(concat(digitalocean_volume.igw.*.droplet_ids, [""]), 0)
  description = "A list of associated droplet ids."
}

output "igw_volume_snapshot_id" {
  value       = element(concat(digitalocean_volume.igw.*.snapshot_id, [""]), 0)
  description = "The ID of the existing volume snapshot from which this volume was created from."
}

output "igw_volume_filesystem_type" {
  value       = element(concat(digitalocean_volume.igw.*.filesystem_type, [""]), 0)
  description = "Filesystem type (xfs or ext4) for the block storage volume."
}

output "igw_volume_filesystem_label" {
  value       = element(concat(digitalocean_volume.igw.*.filesystem_label, [""]), 0)
  description = "Filesystem label for the block storage volume."
}

output "igw_volume_initial_filesystem_type" {
  value       = element(concat(digitalocean_volume.igw.*.initial_filesystem_type, [""]), 0)
  description = "Filesystem type (xfs or ext4) for the block storage volume when it was first created."
}

output "igw_volume_initial_filesystem_label" {
  value       = element(concat(digitalocean_volume.igw.*.initial_filesystem_label, [""]), 0)
  description = "Filesystem label for the block storage volume when it was first created."
}

#--------------------------------------------------------------
# Internet Gateway Firewall
#--------------------------------------------------------------

output "igw_firewall_id" {
  value       = element(concat(digitalocean_firewall.igw.*.id, [""]), 0)
  description = "A unique ID that can be used to identify and reference a Firewall."
}

output "igw_firewall_status" {
  value       = element(concat(digitalocean_firewall.igw.*.status, [""]), 0)
  description = "A status string indicating the current state of the Firewall. This can be 'waiting', 'succeeded', or 'failed'."
}

output "igw_firewall_created_at" {
  value       = element(concat(digitalocean_firewall.igw.*.created_at, [""]), 0)
  description = "A time value given in ISO8601 combined date and time format that represents when the Firewall was created."
}

output "igw_firewall_pending_changes" {
  value       = element(concat(digitalocean_firewall.igw.*.pending_changes, [""]), 0)
  description = "An list of object containing the fields, 'droplet_id', 'removing', and 'status'. It is provided to detail exactly which Droplets are having their security policies updated. When empty, all changes have been successfully applied."
}

output "igw_firewall_name" {
  value       = element(concat(digitalocean_firewall.igw.*.name, [""]), 0)
  description = "The name of the Firewall."
}

output "igw_firewall_droplet_ids" {
  value       = element(concat(digitalocean_firewall.igw.*.droplet_ids, [""]), 0)
  description = "The list of the IDs of the Droplets assigned to the Firewall."
}

output "igw_firewall_tags" {
  value       = element(concat(digitalocean_firewall.igw.*.tags, [""]), 0)
  description = "The names of the Tags assigned to the Firewall."
}

# output "igw_firewall_inbound_rules" {
#   value = element(concat(digitalocean_firewall.igw.*.inbound_rules, [""]), 0)
#   description = "The inbound access rule block for the Firewall."
# }
# 
# output "igw_firewall_outbound_rules" {
#   value = element(concat(digitalocean_firewall.igw.*.outbound_rules, [""]), 0)
#   description = "The outbound access rule block for the Firewall."
# }

#--------------------------------------------------------------
# Private Droplet(s)
#--------------------------------------------------------------

output "private_droplet_id" {
  value       = element(concat(digitalocean_droplet.private.*.id, [""]), 0)
  description = "The ID of the Droplet"
}

output "private_droplet_urn" {
  value       = element(concat(digitalocean_droplet.private.*.urn, [""]), 0)
  description = "The uniform resource name of the Droplet"
}

output "private_droplet_name" {
  value       = element(concat(digitalocean_droplet.private.*.name, [""]), 0)
  description = "The name of the Droplet"
}

output "private_droplet_region" {
  value       = element(concat(digitalocean_droplet.private.*.region, [""]), 0)
  description = "The region of the Droplet"
}

output "private_droplet_image" {
  value       = element(concat(digitalocean_droplet.private.*.image, [""]), 0)
  description = "The image of the Droplet"
}

output "private_droplet_ipv6" {
  value       = element(concat(digitalocean_droplet.private.*.ipv6, [""]), 0)
  description = "Is IPv6 enabled"
}

output "private_droplet_ipv6_address" {
  value       = element(concat(digitalocean_droplet.private.*.ipv6_address, [""]), 0)
  description = "The IPv6 address"
}

output "private_droplet_ipv4_address" {
  value       = element(concat(digitalocean_droplet.private.*.ipv4_address, [""]), 0)
  description = "The IPv4 address"
}

output "private_droplet_ipv4_address_private" {
  value       = element(concat(digitalocean_droplet.private.*.ipv4_address_private, [""]), 0)
  description = "The IPv4 address"
}

output "private_droplet_locked" {
  value       = element(concat(digitalocean_droplet.private.*.locked, [""]), 0)
  description = "The IPv4 address"
}

output "private_droplet_private_networking" {
  value       = element(concat(digitalocean_droplet.private.*.private_networking, [""]), 0)
  description = "Is private networking enabled"
}

output "private_droplet_price_hourly" {
  value       = element(concat(digitalocean_droplet.private.*.price_hourly, [""]), 0)
  description = "Droplet hourly price"
}

output "private_droplet_price_monthly" {
  value       = element(concat(digitalocean_droplet.private.*.price_monthly, [""]), 0)
  description = "Droplet monthly price"
}

output "private_droplet_size" {
  value       = element(concat(digitalocean_droplet.private.*.size, [""]), 0)
  description = "The instance size"
}

output "private_droplet_disk" {
  value       = element(concat(digitalocean_droplet.private.*.disk, [""]), 0)
  description = "The size of the instance's disk in GB"
}

output "private_droplet_vcpus" {
  value       = element(concat(digitalocean_droplet.private.*.vcpus, [""]), 0)
  description = "The number of the instance's virtual CPUs"
}

output "private_droplet_status" {
  value       = element(concat(digitalocean_droplet.private.*.status, [""]), 0)
  description = "The status of the Droplet"
}

output "private_droplet_tags" {
  value       = element(concat(digitalocean_droplet.private.*.tags, [""]), 0)
  description = "The tags associated with the Droplet"
}

output "private_droplet_volume_ids" {
  value       = element(concat(digitalocean_droplet.private.*.volume_ids, [""]), 0)
  description = "A list of the attached block storage volumes"
}

#--------------------------------------------------------------
# Private Volume
#--------------------------------------------------------------

output "private_volume_id" {
  value       = element(concat(digitalocean_volume.private.*.id, [""]), 0)
  description = "The unique identifier for the volume."
}

output "private_volume_urn" {
  value       = element(concat(digitalocean_volume.private.*.urn, [""]), 0)
  description = "The uniform resource name for the volume."
}

output "private_volume_name" {
  value       = element(concat(digitalocean_volume.private.*.name, [""]), 0)
  description = "Name of the volume."
}

output "private_volume_description" {
  value       = element(concat(digitalocean_volume.private.*.description, [""]), 0)
  description = "Description of the volume."
}

output "private_volume_tags" {
  value       = element(concat(digitalocean_volume.private.*.tags, [""]), 0)
  description = "List of applied tags to the volume."
}

output "private_volume_region" {
  value       = element(concat(digitalocean_volume.private.*.region, [""]), 0)
  description = "The region that the volume is created in."
}

output "private_volume_droplet_ids" {
  value       = element(concat(digitalocean_volume.private.*.droplet_ids, [""]), 0)
  description = "A list of associated droplet ids."
}

output "private_volume_snapshot_id" {
  value       = element(concat(digitalocean_volume.private.*.snapshot_id, [""]), 0)
  description = "The ID of the existing volume snapshot from which this volume was created from."
}

output "private_volume_filesystem_type" {
  value       = element(concat(digitalocean_volume.private.*.filesystem_type, [""]), 0)
  description = "Filesystem type (xfs or ext4) for the block storage volume."
}

output "private_volume_filesystem_label" {
  value       = element(concat(digitalocean_volume.private.*.filesystem_label, [""]), 0)
  description = "Filesystem label for the block storage volume."
}

output "private_volume_initial_filesystem_type" {
  value       = element(concat(digitalocean_volume.private.*.initial_filesystem_type, [""]), 0)
  description = "Filesystem type (xfs or ext4) for the block storage volume when it was first created."
}

output "private_volume_initial_filesystem_label" {
  value       = element(concat(digitalocean_volume.private.*.initial_filesystem_label, [""]), 0)
  description = "Filesystem label for the block storage volume when it was first created."
}

#--------------------------------------------------------------
# Private Droplet Firewall
#--------------------------------------------------------------

output "private_firewall_id" {
  value       = element(concat(digitalocean_firewall.private.*.id, [""]), 0)
  description = "A unique ID that can be used to identify and reference a Firewall."
}

output "private_firewall_status" {
  value       = element(concat(digitalocean_firewall.private.*.status, [""]), 0)
  description = "A status string indicating the current state of the Firewall. This can be 'waiting', 'succeeded', or 'failed'."
}

output "private_firewall_created_at" {
  value       = element(concat(digitalocean_firewall.private.*.created_at, [""]), 0)
  description = "A time value given in ISO8601 combined date and time format that represents when the Firewall was created."
}

output "private_firewall_pending_changes" {
  value       = element(concat(digitalocean_firewall.private.*.pending_changes, [""]), 0)
  description = "An list of object containing the fields, 'droplet_id', 'removing', and 'status'. It is provided to detail exactly which Droplets are having their security policies updated. When empty, all changes have been successfully applied."
}

output "private_firewall_name" {
  value       = element(concat(digitalocean_firewall.private.*.name, [""]), 0)
  description = "The name of the Firewall."
}

output "private_firewall_droplet_ids" {
  value       = element(concat(digitalocean_firewall.private.*.droplet_ids, [""]), 0)
  description = "The list of the IDs of the Droplets assigned to the Firewall."
}

output "private_firewall_tags" {
  value       = element(concat(digitalocean_firewall.private.*.tags, [""]), 0)
  description = "The names of the Tags assigned to the Firewall."
}

# output "private_firewall_inbound_rules" {
#   value = element(concat(digitalocean_firewall.private.*.inbound_rules, [""]), 0)
#   description = "The inbound access rule block for the Firewall."
# }
# 
# output "private_firewall_outbound_rules" {
#   value = element(concat(digitalocean_firewall.private.*.outbound_rules, [""]), 0)
#   description = "The outbound access rule block for the Firewall."
# }
