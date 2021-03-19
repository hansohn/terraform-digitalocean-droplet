# terraform-digitalocean-droplet

Terraform module to build a Digitalocean droplet

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| digitalocean | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| igw_label | git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.19.2 |  |
| label | git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.19.2 |  |
| private_label | git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.19.2 |  |
| ssh_key | ./modules/ssh-key |  |

## Resources

| Name |
|------|
| [digitalocean_droplet](https://registry.terraform.io/providers/hashicorp/digitalocean/latest/docs/resources/droplet) |
| [digitalocean_firewall](https://registry.terraform.io/providers/hashicorp/digitalocean/latest/docs/resources/firewall) |
| [digitalocean_floating_ip](https://registry.terraform.io/providers/hashicorp/digitalocean/latest/docs/resources/floating_ip) |
| [digitalocean_floating_ip_assignment](https://registry.terraform.io/providers/hashicorp/digitalocean/latest/docs/resources/floating_ip_assignment) |
| [digitalocean_volume](https://registry.terraform.io/providers/hashicorp/digitalocean/latest/docs/resources/volume) |
| [digitalocean_volume_attachment](https://registry.terraform.io/providers/hashicorp/digitalocean/latest/docs/resources/volume_attachment) |
| [digitalocean_vpc](https://registry.terraform.io/providers/hashicorp/digitalocean/latest/docs/resources/vpc) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_tag\_map | Additional tags for appending to tags\_as\_list\_of\_maps. Not added to `tags`. | `map(string)` | `{}` | no |
| algorithm | SSH key algorithm | `string` | `"RSA"` | no |
| attributes | Additional attributes (e.g. `1`) | `list(string)` | `[]` | no |
| context | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | <pre>object({<br>    enabled             = bool<br>    namespace           = string<br>    environment         = string<br>    stage               = string<br>    name                = string<br>    delimiter           = string<br>    attributes          = list(string)<br>    tags                = map(string)<br>    additional_tag_map  = map(string)<br>    regex_replace_chars = string<br>    label_order         = list(string)<br>    id_length_limit     = number<br>  })</pre> | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_order": [],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {}<br>}</pre> | no |
| delimiter | Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes`.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| ecdsa\_curve | (Optional) When algorithm is 'ECDSA', the name of the elliptic curve to use. May be any one of 'P224', 'P256', 'P384' or 'P521', with 'P224' as the default. | `string` | `null` | no |
| enabled | Set to false to prevent the module from creating any resources | `bool` | `true` | no |
| environment | Environment, e.g. 'uw2', 'us-west-2', OR 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| generate\_ssh\_key | If set to `true`, new SSH key pair will be created and `ssh_public_key_file` will be ignored. Conflicts with ssh\_public\_key\_file | `bool` | `false` | no |
| id\_length\_limit | Limit `id` to this many characters.<br>Set to `0` for unlimited length.<br>Set to `null` for default, which is `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| igw\_droplet\_backups | (Optional) Boolean controlling if backups are made. Defaults to false. | `bool` | `null` | no |
| igw\_droplet\_enable\_bastion | (Optional) Boolean controlling whether to enable bastion ssh feature on droplet | `bool` | `false` | no |
| igw\_droplet\_enable\_notifications | (Optional) Boolean controlling whether to enable slack notifications. Currently this feature only applies to bastion fail2ban sshd jail notifications. | `bool` | `false` | no |
| igw\_droplet\_image | (Required) The Droplet image ID or slug. | `string` | `null` | no |
| igw\_droplet\_ipv6 | (Optional) Boolean controlling if IPv6 is enabled. Defaults to false. | `bool` | `null` | no |
| igw\_droplet\_monitoring | (Optional) Boolean controlling whether monitoring agent is installed. Defaults to false. | `bool` | `true` | no |
| igw\_droplet\_name | (Required) The Droplet name. | `string` | `null` | no |
| igw\_droplet\_resize\_disk | (Optional) Boolean controlling whether to increase the disk size when resizing a Droplet. It defaults to true. When set to false, only the Droplet's RAM and CPU will be resized. Increasing a Droplet's disk size is a permanent change. Increasing only RAM and CPU is reversible. | `bool` | `null` | no |
| igw\_droplet\_size | (Required) The unique slug that indentifies the type of Droplet. | `string` | `"s-1vcpu-1gb"` | no |
| igw\_droplet\_ssh\_keys | (Optional) A list of SSH IDs or fingerprints to enable in the format [12345, 123456]. | `list(string)` | `null` | no |
| igw\_droplet\_tags | (Optional) A list of the tags to be applied to this Droplet. | `list(string)` | `null` | no |
| igw\_droplet\_user\_data | (Optional) - A string of the desired User Data for the Droplet. | `string` | `null` | no |
| igw\_droplet\_volume\_ids | (Optional) - A list of the IDs of each block storage volume to be attached to the Droplet. | `list(string)` | `null` | no |
| igw\_droplet\_vpc\_uuid | (Optional) The ID of the VPC where the Droplet will be located. | `string` | `null` | no |
| igw\_firewall\_inbound\_rules | (Optional) The inbound access rule block for the Firewall. | `list(any)` | <pre>[<br>  {<br>    "port_range": "22",<br>    "protocol": "tcp",<br>    "source_addresses": "0.0.0.0/0, ::/0"<br>  }<br>]</pre> | no |
| igw\_firewall\_name | (Required) The Firewall name | `string` | `null` | no |
| igw\_firewall\_outbound\_rules | (Optional) The outbound access rule block for the Firewall. | `list(any)` | <pre>[<br>  {<br>    "destination_addresses": "0.0.0.0/0, ::/0",<br>    "protocol": "icmp"<br>  },<br>  {<br>    "destination_addresses": "0.0.0.0/0, ::/0",<br>    "port_range": "1-65535",<br>    "protocol": "tcp"<br>  },<br>  {<br>    "destination_addresses": "0.0.0.0/0, ::/0",<br>    "port_range": "1-65535",<br>    "protocol": "udp"<br>  }<br>]</pre> | no |
| igw\_volume\_description | (Optional) A free-form text field up to a limit of 1024 bytes to describe a block storage volume. | `string` | `null` | no |
| igw\_volume\_enabled | Boolean controlling whether a volume will be created and attached to the internet gateway instnace | `bool` | `false` | no |
| igw\_volume\_initial\_filesystem\_label | (Optional) Initial filesystem label for the block storage volume. | `string` | `null` | no |
| igw\_volume\_initial\_filesystem\_type | (Optional) Initial filesystem type (xfs or ext4) for the block storage volume. | `string` | `null` | no |
| igw\_volume\_name | (Required) A name for the block storage volume. Must be lowercase and be composed only of numbers, letters and '-', up to a limit of 64 characters. | `string` | `null` | no |
| igw\_volume\_size | (Required) The size of the block storage volume in GiB. If updated, can only be expanded. | `number` | `null` | no |
| igw\_volume\_snapshot\_id | (Optional) The ID of an existing volume snapshot from which the new volume will be created. If supplied, the region and size will be limitied on creation to that of the referenced snapshot | `string` | `null` | no |
| igw\_volume\_tags | (Optional) A list of the tags to be applied to this Volume. | `list(string)` | `null` | no |
| label\_order | The naming order of the id output and Name tag.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 5 elements, but at least one must be present. | `list(string)` | `null` | no |
| local\_download\_enabled | (Optional) If generate\_ssh\_key enabled, the key pair will be downloaded locally to the ssh\_key\_path | `bool` | `true` | no |
| local\_ssh\_key\_path | Path to local SSH public key directory (e.g. `/secrets`) | `string` | `null` | no |
| name | Solution name, e.g. 'app' or 'jenkins' | `string` | `null` | no |
| namespace | Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp' | `string` | `null` | no |
| private\_droplet\_backups | (Optional) Boolean controlling if backups are made. Defaults to false. | `bool` | `null` | no |
| private\_droplet\_count | (Optional) Number of private droplet instances to create. Defauts to 1. | `number` | `1` | no |
| private\_droplet\_image | (Required) The Droplet image ID or slug. | `string` | `null` | no |
| private\_droplet\_ipv6 | (Optional) Boolean controlling if IPv6 is enabled. Defaults to false. | `bool` | `null` | no |
| private\_droplet\_monitoring | (Optional) Boolean controlling whether monitoring agent is installed. Defaults to false. | `bool` | `null` | no |
| private\_droplet\_name | (Required) The Droplet name. | `string` | `null` | no |
| private\_droplet\_resize\_disk | (Optional) Boolean controlling whether to increase the disk size when resizing a Droplet. It defaults to true. When set to false, only the Droplet's RAM and CPU will be resized. Increasing a Droplet's disk size is a permanent change. Increasing only RAM and CPU is reversible. | `bool` | `null` | no |
| private\_droplet\_size | (Required) The unique slug that indentifies the type of Droplet. | `string` | `"s-1vcpu-1gb"` | no |
| private\_droplet\_ssh\_keys | (Optional) A list of SSH IDs or fingerprints to enable in the format [12345, 123456]. | `list(string)` | `null` | no |
| private\_droplet\_tags | (Optional) A list of the tags to be applied to this Droplet. | `list(string)` | `null` | no |
| private\_droplet\_user\_data | (Optional) - A string of the desired User Data for the Droplet. | `string` | `null` | no |
| private\_droplet\_volume\_ids | (Optional) - A list of the IDs of each block storage volume to be attached to the Droplet. | `list(string)` | `null` | no |
| private\_droplet\_vpc\_uuid | (Optional) The ID of the VPC where the Droplet will be located. | `string` | `null` | no |
| private\_firewall\_inbound\_rules | (Optional) The inbound access rule block for the Firewall. | `list(any)` | `[]` | no |
| private\_firewall\_name | (Required) The Firewall name | `string` | `null` | no |
| private\_firewall\_outbound\_rules | (Optional) The outbound access rule block for the Firewall. | `list(any)` | `[]` | no |
| private\_volume\_description | (Optional) A free-form text field up to a limit of 1024 bytes to describe a block storage volume. | `string` | `null` | no |
| private\_volume\_enabled | Boolean controlling whether a volume will be created and attached to the private instnace(s) | `bool` | `false` | no |
| private\_volume\_initial\_filesystem\_label | (Optional) Initial filesystem label for the block storage volume. | `string` | `null` | no |
| private\_volume\_initial\_filesystem\_type | (Optional) Initial filesystem type (xfs or ext4) for the block storage volume. | `string` | `null` | no |
| private\_volume\_name | (Required) A name for the block storage volume. Must be lowercase and be composed only of numbers, letters and '-', up to a limit of 64 characters. | `string` | `null` | no |
| private\_volume\_size | (Required) The size of the block storage volume in GiB. If updated, can only be expanded. | `number` | `null` | no |
| private\_volume\_snapshot\_id | (Optional) The ID of an existing volume snapshot from which the new volume will be created. If supplied, the region and size will be limitied on creation to that of the referenced snapshot | `string` | `null` | no |
| private\_volume\_tags | (Optional) A list of the tags to be applied to this Volume. | `list(string)` | `null` | no |
| regex\_replace\_chars | Regex to replace chars with empty string in `namespace`, `environment`, `stage` and `name`.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| rsa\_bits | (Optional) When algorithm is 'RSA', the size of the generated RSA key in bits. Defaults to 2048. | `number` | `null` | no |
| slack\_channel | (Optional) The name of the channel to be used as the destination for webhook messages. | `string` | `""` | no |
| slack\_icon | (Optional) Slack emoji icon to used for notifications. | `string` | `""` | no |
| slack\_username | (Optional) Slack username to post on behalf of for notifications. | `string` | `""` | no |
| slack\_webhook\_url | (Optional) The Incoming Webhook URL | `string` | `""` | no |
| ssh\_key\_name | If ssh\_public\_key\_file and generate\_ssh\_key are undefined, the name of existing DigitalOcean ssh key to utilize. If ssh\_public\_key\_file or generate\_ssh\_key are defined, the name to be assoicated with the ssh key in DigitalOcean | `string` | `null` | no |
| ssh\_public\_key\_file | Filename (including path) of existing SSH public key file (e.g. `/path/to/id_rsa.pub`). Confilcts with generate\_ssh\_key. | `string` | `null` | no |
| stage | Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| tags | Additional tags (e.g. `map('BusinessUnit','XYZ')` | `map(string)` | `{}` | no |
| vpc\_description | (Optional) A free-form text field up to a limit of 255 characters to describe the VPC. | `string` | `null` | no |
| vpc\_ip\_range | (Optional) The range of IP addresses for the VPC in CIDR notation. Network ranges cannot overlap with other networks in the same account and must be in range of private addresses as defined in RFC1918. It may not be larger than /16 or smaller than /24. | `string` | `null` | no |
| vpc\_name | (Required) A name for the VPC. Must be unique and contain alphanumeric characters, dashes, and periods only. | `string` | `null` | no |
| vpc\_region | (Required) The DigitalOcean region slug for the VPC's location. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| floating\_ip\_address | The IP Address of the resource |
| floating\_ip\_urn | The uniform resource name of the floating ip |
| igw\_droplet\_disk | The size of the instance's disk in GB |
| igw\_droplet\_id | The ID of the Droplet |
| igw\_droplet\_image | The image of the Droplet |
| igw\_droplet\_ipv4\_address | The IPv4 address |
| igw\_droplet\_ipv4\_address\_private | The IPv4 address |
| igw\_droplet\_ipv6 | Is IPv6 enabled |
| igw\_droplet\_ipv6\_address | The IPv6 address |
| igw\_droplet\_locked | The IPv4 address |
| igw\_droplet\_name | The name of the Droplet |
| igw\_droplet\_price\_hourly | Droplet hourly price |
| igw\_droplet\_price\_monthly | Droplet monthly price |
| igw\_droplet\_private\_networking | Is private networking enabled |
| igw\_droplet\_region | The region of the Droplet |
| igw\_droplet\_size | The instance size |
| igw\_droplet\_status | The status of the Droplet |
| igw\_droplet\_tags | The tags associated with the Droplet |
| igw\_droplet\_urn | The uniform resource name of the Droplet |
| igw\_droplet\_vcpus | The number of the instance's virtual CPUs |
| igw\_droplet\_volume\_ids | A list of the attached block storage volumes |
| igw\_firewall\_created\_at | A time value given in ISO8601 combined date and time format that represents when the Firewall was created. |
| igw\_firewall\_droplet\_ids | The list of the IDs of the Droplets assigned to the Firewall. |
| igw\_firewall\_id | A unique ID that can be used to identify and reference a Firewall. |
| igw\_firewall\_name | The name of the Firewall. |
| igw\_firewall\_pending\_changes | An list of object containing the fields, 'droplet\_id', 'removing', and 'status'. It is provided to detail exactly which Droplets are having their security policies updated. When empty, all changes have been successfully applied. |
| igw\_firewall\_status | A status string indicating the current state of the Firewall. This can be 'waiting', 'succeeded', or 'failed'. |
| igw\_firewall\_tags | The names of the Tags assigned to the Firewall. |
| igw\_volume\_description | Description of the volume. |
| igw\_volume\_droplet\_ids | A list of associated droplet ids. |
| igw\_volume\_filesystem\_label | Filesystem label for the block storage volume. |
| igw\_volume\_filesystem\_type | Filesystem type (xfs or ext4) for the block storage volume. |
| igw\_volume\_id | The unique identifier for the volume. |
| igw\_volume\_initial\_filesystem\_label | Filesystem label for the block storage volume when it was first created. |
| igw\_volume\_initial\_filesystem\_type | Filesystem type (xfs or ext4) for the block storage volume when it was first created. |
| igw\_volume\_name | Name of the volume. |
| igw\_volume\_region | The region that the volume is created in. |
| igw\_volume\_snapshot\_id | The ID of the existing volume snapshot from which this volume was created from. |
| igw\_volume\_tags | List of applied tags to the volume. |
| igw\_volume\_urn | The uniform resource name for the volume. |
| private\_droplet\_disk | The size of the instance's disk in GB |
| private\_droplet\_id | The ID of the Droplet |
| private\_droplet\_image | The image of the Droplet |
| private\_droplet\_ipv4\_address | The IPv4 address |
| private\_droplet\_ipv4\_address\_private | The IPv4 address |
| private\_droplet\_ipv6 | Is IPv6 enabled |
| private\_droplet\_ipv6\_address | The IPv6 address |
| private\_droplet\_locked | The IPv4 address |
| private\_droplet\_name | The name of the Droplet |
| private\_droplet\_price\_hourly | Droplet hourly price |
| private\_droplet\_price\_monthly | Droplet monthly price |
| private\_droplet\_private\_networking | Is private networking enabled |
| private\_droplet\_region | The region of the Droplet |
| private\_droplet\_size | The instance size |
| private\_droplet\_status | The status of the Droplet |
| private\_droplet\_tags | The tags associated with the Droplet |
| private\_droplet\_urn | The uniform resource name of the Droplet |
| private\_droplet\_vcpus | The number of the instance's virtual CPUs |
| private\_droplet\_volume\_ids | A list of the attached block storage volumes |
| private\_firewall\_created\_at | A time value given in ISO8601 combined date and time format that represents when the Firewall was created. |
| private\_firewall\_droplet\_ids | The list of the IDs of the Droplets assigned to the Firewall. |
| private\_firewall\_id | A unique ID that can be used to identify and reference a Firewall. |
| private\_firewall\_name | The name of the Firewall. |
| private\_firewall\_pending\_changes | An list of object containing the fields, 'droplet\_id', 'removing', and 'status'. It is provided to detail exactly which Droplets are having their security policies updated. When empty, all changes have been successfully applied. |
| private\_firewall\_status | A status string indicating the current state of the Firewall. This can be 'waiting', 'succeeded', or 'failed'. |
| private\_firewall\_tags | The names of the Tags assigned to the Firewall. |
| private\_volume\_description | Description of the volume. |
| private\_volume\_droplet\_ids | A list of associated droplet ids. |
| private\_volume\_filesystem\_label | Filesystem label for the block storage volume. |
| private\_volume\_filesystem\_type | Filesystem type (xfs or ext4) for the block storage volume. |
| private\_volume\_id | The unique identifier for the volume. |
| private\_volume\_initial\_filesystem\_label | Filesystem label for the block storage volume when it was first created. |
| private\_volume\_initial\_filesystem\_type | Filesystem type (xfs or ext4) for the block storage volume when it was first created. |
| private\_volume\_name | Name of the volume. |
| private\_volume\_region | The region that the volume is created in. |
| private\_volume\_snapshot\_id | The ID of the existing volume snapshot from which this volume was created from. |
| private\_volume\_tags | List of applied tags to the volume. |
| private\_volume\_urn | The uniform resource name for the volume. |
| vpc\_created\_at | The date and time of when the VPC was created. |
| vpc\_default | A boolean indicating whether or not the VPC is the default one for the region. |
| vpc\_id | The unique identifier for the VPC. |
| vpc\_urn | The uniform resource name (URN) for the VPC. |
