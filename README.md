# terraform-digitalocean-droplet

Terraform module to build a Digitalocean droplet

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | 2.10.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_igw_label"></a> [igw\_label](#module\_igw\_label) | cloudposse/label/null | 0.24.1 |
| <a name="module_private_label"></a> [private\_label](#module\_private\_label) | cloudposse/label/null | 0.24.1 |
| <a name="module_ssh_key"></a> [ssh\_key](#module\_ssh\_key) | ./modules/ssh-key | n/a |
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.24.1 |

## Resources

| Name | Type |
|------|------|
| [digitalocean_droplet.igw](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet) | resource |
| [digitalocean_droplet.private](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet) | resource |
| [digitalocean_firewall.igw](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/firewall) | resource |
| [digitalocean_firewall.private](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/firewall) | resource |
| [digitalocean_floating_ip.this](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/floating_ip) | resource |
| [digitalocean_floating_ip_assignment.igw](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/floating_ip_assignment) | resource |
| [digitalocean_volume.igw](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/volume) | resource |
| [digitalocean_volume.private](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/volume) | resource |
| [digitalocean_volume_attachment.igw](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/volume_attachment) | resource |
| [digitalocean_volume_attachment.private](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/volume_attachment) | resource |
| [digitalocean_vpc.this](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional tags for appending to tags\_as\_list\_of\_maps. Not added to `tags`. | `map(string)` | `{}` | no |
| <a name="input_algorithm"></a> [algorithm](#input\_algorithm) | SSH key algorithm | `string` | `"RSA"` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | Additional attributes (e.g. `1`) | `list(string)` | `[]` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {}<br>}</pre> | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes`.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_ecdsa_curve"></a> [ecdsa\_curve](#input\_ecdsa\_curve) | (Optional) When algorithm is 'ECDSA', the name of the elliptic curve to use. May be any one of 'P224', 'P256', 'P384' or 'P521', with 'P224' as the default. | `string` | `null` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment, e.g. 'uw2', 'us-west-2', OR 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_generate_ssh_key"></a> [generate\_ssh\_key](#input\_generate\_ssh\_key) | If set to `true`, new SSH key pair will be created and `ssh_public_key_file` will be ignored. Conflicts with ssh\_public\_key\_file | `bool` | `false` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for default, which is `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_igw_droplet_backups"></a> [igw\_droplet\_backups](#input\_igw\_droplet\_backups) | (Optional) Boolean controlling if backups are made. Defaults to false. | `bool` | `null` | no |
| <a name="input_igw_droplet_enable_bastion"></a> [igw\_droplet\_enable\_bastion](#input\_igw\_droplet\_enable\_bastion) | (Optional) Boolean controlling whether to enable bastion ssh feature on droplet | `bool` | `false` | no |
| <a name="input_igw_droplet_enable_notifications"></a> [igw\_droplet\_enable\_notifications](#input\_igw\_droplet\_enable\_notifications) | (Optional) Boolean controlling whether to enable slack notifications. Currently this feature only applies to bastion fail2ban sshd jail notifications. | `bool` | `false` | no |
| <a name="input_igw_droplet_image"></a> [igw\_droplet\_image](#input\_igw\_droplet\_image) | (Required) The Droplet image ID or slug. | `string` | `null` | no |
| <a name="input_igw_droplet_ipv6"></a> [igw\_droplet\_ipv6](#input\_igw\_droplet\_ipv6) | (Optional) Boolean controlling if IPv6 is enabled. Defaults to false. | `bool` | `null` | no |
| <a name="input_igw_droplet_monitoring"></a> [igw\_droplet\_monitoring](#input\_igw\_droplet\_monitoring) | (Optional) Boolean controlling whether monitoring agent is installed. Defaults to false. | `bool` | `true` | no |
| <a name="input_igw_droplet_name"></a> [igw\_droplet\_name](#input\_igw\_droplet\_name) | (Required) The Droplet name. | `string` | `null` | no |
| <a name="input_igw_droplet_resize_disk"></a> [igw\_droplet\_resize\_disk](#input\_igw\_droplet\_resize\_disk) | (Optional) Boolean controlling whether to increase the disk size when resizing a Droplet. It defaults to true. When set to false, only the Droplet's RAM and CPU will be resized. Increasing a Droplet's disk size is a permanent change. Increasing only RAM and CPU is reversible. | `bool` | `null` | no |
| <a name="input_igw_droplet_size"></a> [igw\_droplet\_size](#input\_igw\_droplet\_size) | (Required) The unique slug that indentifies the type of Droplet. | `string` | `"s-1vcpu-1gb"` | no |
| <a name="input_igw_droplet_ssh_keys"></a> [igw\_droplet\_ssh\_keys](#input\_igw\_droplet\_ssh\_keys) | (Optional) A list of SSH IDs or fingerprints to enable in the format [12345, 123456]. | `list(string)` | `null` | no |
| <a name="input_igw_droplet_tags"></a> [igw\_droplet\_tags](#input\_igw\_droplet\_tags) | (Optional) A list of the tags to be applied to this Droplet. | `list(string)` | `null` | no |
| <a name="input_igw_droplet_user_data"></a> [igw\_droplet\_user\_data](#input\_igw\_droplet\_user\_data) | (Optional) - A string of the desired User Data for the Droplet. | `string` | `null` | no |
| <a name="input_igw_droplet_volume_ids"></a> [igw\_droplet\_volume\_ids](#input\_igw\_droplet\_volume\_ids) | (Optional) - A list of the IDs of each block storage volume to be attached to the Droplet. | `list(string)` | `null` | no |
| <a name="input_igw_droplet_vpc_uuid"></a> [igw\_droplet\_vpc\_uuid](#input\_igw\_droplet\_vpc\_uuid) | (Optional) The ID of the VPC where the Droplet will be located. | `string` | `null` | no |
| <a name="input_igw_firewall_inbound_rules"></a> [igw\_firewall\_inbound\_rules](#input\_igw\_firewall\_inbound\_rules) | (Optional) The inbound access rule block for the Firewall. | `list(any)` | <pre>[<br>  {<br>    "port_range": "22",<br>    "protocol": "tcp",<br>    "source_addresses": "0.0.0.0/0, ::/0"<br>  }<br>]</pre> | no |
| <a name="input_igw_firewall_name"></a> [igw\_firewall\_name](#input\_igw\_firewall\_name) | (Required) The Firewall name | `string` | `null` | no |
| <a name="input_igw_firewall_outbound_rules"></a> [igw\_firewall\_outbound\_rules](#input\_igw\_firewall\_outbound\_rules) | (Optional) The outbound access rule block for the Firewall. | `list(any)` | <pre>[<br>  {<br>    "destination_addresses": "0.0.0.0/0, ::/0",<br>    "protocol": "icmp"<br>  },<br>  {<br>    "destination_addresses": "0.0.0.0/0, ::/0",<br>    "port_range": "1-65535",<br>    "protocol": "tcp"<br>  },<br>  {<br>    "destination_addresses": "0.0.0.0/0, ::/0",<br>    "port_range": "1-65535",<br>    "protocol": "udp"<br>  }<br>]</pre> | no |
| <a name="input_igw_volume_description"></a> [igw\_volume\_description](#input\_igw\_volume\_description) | (Optional) A free-form text field up to a limit of 1024 bytes to describe a block storage volume. | `string` | `null` | no |
| <a name="input_igw_volume_enabled"></a> [igw\_volume\_enabled](#input\_igw\_volume\_enabled) | Boolean controlling whether a volume will be created and attached to the internet gateway instnace | `bool` | `false` | no |
| <a name="input_igw_volume_initial_filesystem_label"></a> [igw\_volume\_initial\_filesystem\_label](#input\_igw\_volume\_initial\_filesystem\_label) | (Optional) Initial filesystem label for the block storage volume. | `string` | `null` | no |
| <a name="input_igw_volume_initial_filesystem_type"></a> [igw\_volume\_initial\_filesystem\_type](#input\_igw\_volume\_initial\_filesystem\_type) | (Optional) Initial filesystem type (xfs or ext4) for the block storage volume. | `string` | `null` | no |
| <a name="input_igw_volume_name"></a> [igw\_volume\_name](#input\_igw\_volume\_name) | (Required) A name for the block storage volume. Must be lowercase and be composed only of numbers, letters and '-', up to a limit of 64 characters. | `string` | `null` | no |
| <a name="input_igw_volume_size"></a> [igw\_volume\_size](#input\_igw\_volume\_size) | (Required) The size of the block storage volume in GiB. If updated, can only be expanded. | `number` | `null` | no |
| <a name="input_igw_volume_snapshot_id"></a> [igw\_volume\_snapshot\_id](#input\_igw\_volume\_snapshot\_id) | (Optional) The ID of an existing volume snapshot from which the new volume will be created. If supplied, the region and size will be limitied on creation to that of the referenced snapshot | `string` | `null` | no |
| <a name="input_igw_volume_tags"></a> [igw\_volume\_tags](#input\_igw\_volume\_tags) | (Optional) A list of the tags to be applied to this Volume. | `list(string)` | `null` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | The letter case of label keys (`tag` names) (i.e. `name`, `namespace`, `environment`, `stage`, `attributes`) to use in `tags`.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The naming order of the id output and Name tag.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 5 elements, but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | The letter case of output label values (also used in `tags` and `id`).<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_local_download_enabled"></a> [local\_download\_enabled](#input\_local\_download\_enabled) | (Optional) If generate\_ssh\_key enabled, the key pair will be downloaded locally to the ssh\_key\_path | `bool` | `true` | no |
| <a name="input_local_ssh_key_path"></a> [local\_ssh\_key\_path](#input\_local\_ssh\_key\_path) | Path to local SSH public key directory (e.g. `/secrets`) | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Solution name, e.g. 'app' or 'jenkins' | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp' | `string` | `null` | no |
| <a name="input_private_droplet_backups"></a> [private\_droplet\_backups](#input\_private\_droplet\_backups) | (Optional) Boolean controlling if backups are made. Defaults to false. | `bool` | `null` | no |
| <a name="input_private_droplet_count"></a> [private\_droplet\_count](#input\_private\_droplet\_count) | (Optional) Number of private droplet instances to create. Defauts to 1. | `number` | `1` | no |
| <a name="input_private_droplet_image"></a> [private\_droplet\_image](#input\_private\_droplet\_image) | (Required) The Droplet image ID or slug. | `string` | `null` | no |
| <a name="input_private_droplet_ipv6"></a> [private\_droplet\_ipv6](#input\_private\_droplet\_ipv6) | (Optional) Boolean controlling if IPv6 is enabled. Defaults to false. | `bool` | `null` | no |
| <a name="input_private_droplet_monitoring"></a> [private\_droplet\_monitoring](#input\_private\_droplet\_monitoring) | (Optional) Boolean controlling whether monitoring agent is installed. Defaults to false. | `bool` | `null` | no |
| <a name="input_private_droplet_name"></a> [private\_droplet\_name](#input\_private\_droplet\_name) | (Required) The Droplet name. | `string` | `null` | no |
| <a name="input_private_droplet_resize_disk"></a> [private\_droplet\_resize\_disk](#input\_private\_droplet\_resize\_disk) | (Optional) Boolean controlling whether to increase the disk size when resizing a Droplet. It defaults to true. When set to false, only the Droplet's RAM and CPU will be resized. Increasing a Droplet's disk size is a permanent change. Increasing only RAM and CPU is reversible. | `bool` | `null` | no |
| <a name="input_private_droplet_size"></a> [private\_droplet\_size](#input\_private\_droplet\_size) | (Required) The unique slug that indentifies the type of Droplet. | `string` | `"s-1vcpu-1gb"` | no |
| <a name="input_private_droplet_ssh_keys"></a> [private\_droplet\_ssh\_keys](#input\_private\_droplet\_ssh\_keys) | (Optional) A list of SSH IDs or fingerprints to enable in the format [12345, 123456]. | `list(string)` | `null` | no |
| <a name="input_private_droplet_tags"></a> [private\_droplet\_tags](#input\_private\_droplet\_tags) | (Optional) A list of the tags to be applied to this Droplet. | `list(string)` | `null` | no |
| <a name="input_private_droplet_user_data"></a> [private\_droplet\_user\_data](#input\_private\_droplet\_user\_data) | (Optional) - A string of the desired User Data for the Droplet. | `string` | `null` | no |
| <a name="input_private_droplet_volume_ids"></a> [private\_droplet\_volume\_ids](#input\_private\_droplet\_volume\_ids) | (Optional) - A list of the IDs of each block storage volume to be attached to the Droplet. | `list(string)` | `null` | no |
| <a name="input_private_droplet_vpc_uuid"></a> [private\_droplet\_vpc\_uuid](#input\_private\_droplet\_vpc\_uuid) | (Optional) The ID of the VPC where the Droplet will be located. | `string` | `null` | no |
| <a name="input_private_firewall_inbound_rules"></a> [private\_firewall\_inbound\_rules](#input\_private\_firewall\_inbound\_rules) | (Optional) The inbound access rule block for the Firewall. | `list(any)` | `[]` | no |
| <a name="input_private_firewall_name"></a> [private\_firewall\_name](#input\_private\_firewall\_name) | (Required) The Firewall name | `string` | `null` | no |
| <a name="input_private_firewall_outbound_rules"></a> [private\_firewall\_outbound\_rules](#input\_private\_firewall\_outbound\_rules) | (Optional) The outbound access rule block for the Firewall. | `list(any)` | `[]` | no |
| <a name="input_private_volume_description"></a> [private\_volume\_description](#input\_private\_volume\_description) | (Optional) A free-form text field up to a limit of 1024 bytes to describe a block storage volume. | `string` | `null` | no |
| <a name="input_private_volume_enabled"></a> [private\_volume\_enabled](#input\_private\_volume\_enabled) | Boolean controlling whether a volume will be created and attached to the private instnace(s) | `bool` | `false` | no |
| <a name="input_private_volume_initial_filesystem_label"></a> [private\_volume\_initial\_filesystem\_label](#input\_private\_volume\_initial\_filesystem\_label) | (Optional) Initial filesystem label for the block storage volume. | `string` | `null` | no |
| <a name="input_private_volume_initial_filesystem_type"></a> [private\_volume\_initial\_filesystem\_type](#input\_private\_volume\_initial\_filesystem\_type) | (Optional) Initial filesystem type (xfs or ext4) for the block storage volume. | `string` | `null` | no |
| <a name="input_private_volume_name"></a> [private\_volume\_name](#input\_private\_volume\_name) | (Required) A name for the block storage volume. Must be lowercase and be composed only of numbers, letters and '-', up to a limit of 64 characters. | `string` | `null` | no |
| <a name="input_private_volume_size"></a> [private\_volume\_size](#input\_private\_volume\_size) | (Required) The size of the block storage volume in GiB. If updated, can only be expanded. | `number` | `null` | no |
| <a name="input_private_volume_snapshot_id"></a> [private\_volume\_snapshot\_id](#input\_private\_volume\_snapshot\_id) | (Optional) The ID of an existing volume snapshot from which the new volume will be created. If supplied, the region and size will be limitied on creation to that of the referenced snapshot | `string` | `null` | no |
| <a name="input_private_volume_tags"></a> [private\_volume\_tags](#input\_private\_volume\_tags) | (Optional) A list of the tags to be applied to this Volume. | `list(string)` | `null` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Regex to replace chars with empty string in `namespace`, `environment`, `stage` and `name`.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_rsa_bits"></a> [rsa\_bits](#input\_rsa\_bits) | (Optional) When algorithm is 'RSA', the size of the generated RSA key in bits. Defaults to 2048. | `number` | `null` | no |
| <a name="input_slack_channel"></a> [slack\_channel](#input\_slack\_channel) | (Optional) The name of the channel to be used as the destination for webhook messages. | `string` | `""` | no |
| <a name="input_slack_icon"></a> [slack\_icon](#input\_slack\_icon) | (Optional) Slack emoji icon to used for notifications. | `string` | `""` | no |
| <a name="input_slack_username"></a> [slack\_username](#input\_slack\_username) | (Optional) Slack username to post on behalf of for notifications. | `string` | `""` | no |
| <a name="input_slack_webhook_url"></a> [slack\_webhook\_url](#input\_slack\_webhook\_url) | (Optional) The Incoming Webhook URL | `string` | `""` | no |
| <a name="input_ssh_key_name"></a> [ssh\_key\_name](#input\_ssh\_key\_name) | If ssh\_public\_key\_file and generate\_ssh\_key are undefined, the name of existing DigitalOcean ssh key to utilize. If ssh\_public\_key\_file or generate\_ssh\_key are defined, the name to be assoicated with the ssh key in DigitalOcean | `string` | `null` | no |
| <a name="input_ssh_public_key_file"></a> [ssh\_public\_key\_file](#input\_ssh\_public\_key\_file) | Filename (including path) of existing SSH public key file (e.g. `/path/to/id_rsa.pub`). Confilcts with generate\_ssh\_key. | `string` | `null` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `map('BusinessUnit','XYZ')` | `map(string)` | `{}` | no |
| <a name="input_vpc_description"></a> [vpc\_description](#input\_vpc\_description) | (Optional) A free-form text field up to a limit of 255 characters to describe the VPC. | `string` | `null` | no |
| <a name="input_vpc_ip_range"></a> [vpc\_ip\_range](#input\_vpc\_ip\_range) | (Optional) The range of IP addresses for the VPC in CIDR notation. Network ranges cannot overlap with other networks in the same account and must be in range of private addresses as defined in RFC1918. It may not be larger than /16 or smaller than /24. | `string` | `null` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | (Required) A name for the VPC. Must be unique and contain alphanumeric characters, dashes, and periods only. | `string` | `null` | no |
| <a name="input_vpc_region"></a> [vpc\_region](#input\_vpc\_region) | (Required) The DigitalOcean region slug for the VPC's location. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_floating_ip_address"></a> [floating\_ip\_address](#output\_floating\_ip\_address) | The IP Address of the resource |
| <a name="output_floating_ip_urn"></a> [floating\_ip\_urn](#output\_floating\_ip\_urn) | The uniform resource name of the floating ip |
| <a name="output_igw_droplet_disk"></a> [igw\_droplet\_disk](#output\_igw\_droplet\_disk) | The size of the instance's disk in GB |
| <a name="output_igw_droplet_id"></a> [igw\_droplet\_id](#output\_igw\_droplet\_id) | The ID of the Droplet |
| <a name="output_igw_droplet_image"></a> [igw\_droplet\_image](#output\_igw\_droplet\_image) | The image of the Droplet |
| <a name="output_igw_droplet_ipv4_address"></a> [igw\_droplet\_ipv4\_address](#output\_igw\_droplet\_ipv4\_address) | The IPv4 address |
| <a name="output_igw_droplet_ipv4_address_private"></a> [igw\_droplet\_ipv4\_address\_private](#output\_igw\_droplet\_ipv4\_address\_private) | The IPv4 address |
| <a name="output_igw_droplet_ipv6"></a> [igw\_droplet\_ipv6](#output\_igw\_droplet\_ipv6) | Is IPv6 enabled |
| <a name="output_igw_droplet_ipv6_address"></a> [igw\_droplet\_ipv6\_address](#output\_igw\_droplet\_ipv6\_address) | The IPv6 address |
| <a name="output_igw_droplet_locked"></a> [igw\_droplet\_locked](#output\_igw\_droplet\_locked) | The IPv4 address |
| <a name="output_igw_droplet_name"></a> [igw\_droplet\_name](#output\_igw\_droplet\_name) | The name of the Droplet |
| <a name="output_igw_droplet_price_hourly"></a> [igw\_droplet\_price\_hourly](#output\_igw\_droplet\_price\_hourly) | Droplet hourly price |
| <a name="output_igw_droplet_price_monthly"></a> [igw\_droplet\_price\_monthly](#output\_igw\_droplet\_price\_monthly) | Droplet monthly price |
| <a name="output_igw_droplet_private_networking"></a> [igw\_droplet\_private\_networking](#output\_igw\_droplet\_private\_networking) | Is private networking enabled |
| <a name="output_igw_droplet_region"></a> [igw\_droplet\_region](#output\_igw\_droplet\_region) | The region of the Droplet |
| <a name="output_igw_droplet_size"></a> [igw\_droplet\_size](#output\_igw\_droplet\_size) | The instance size |
| <a name="output_igw_droplet_status"></a> [igw\_droplet\_status](#output\_igw\_droplet\_status) | The status of the Droplet |
| <a name="output_igw_droplet_tags"></a> [igw\_droplet\_tags](#output\_igw\_droplet\_tags) | The tags associated with the Droplet |
| <a name="output_igw_droplet_urn"></a> [igw\_droplet\_urn](#output\_igw\_droplet\_urn) | The uniform resource name of the Droplet |
| <a name="output_igw_droplet_vcpus"></a> [igw\_droplet\_vcpus](#output\_igw\_droplet\_vcpus) | The number of the instance's virtual CPUs |
| <a name="output_igw_droplet_volume_ids"></a> [igw\_droplet\_volume\_ids](#output\_igw\_droplet\_volume\_ids) | A list of the attached block storage volumes |
| <a name="output_igw_firewall_created_at"></a> [igw\_firewall\_created\_at](#output\_igw\_firewall\_created\_at) | A time value given in ISO8601 combined date and time format that represents when the Firewall was created. |
| <a name="output_igw_firewall_droplet_ids"></a> [igw\_firewall\_droplet\_ids](#output\_igw\_firewall\_droplet\_ids) | The list of the IDs of the Droplets assigned to the Firewall. |
| <a name="output_igw_firewall_id"></a> [igw\_firewall\_id](#output\_igw\_firewall\_id) | A unique ID that can be used to identify and reference a Firewall. |
| <a name="output_igw_firewall_name"></a> [igw\_firewall\_name](#output\_igw\_firewall\_name) | The name of the Firewall. |
| <a name="output_igw_firewall_pending_changes"></a> [igw\_firewall\_pending\_changes](#output\_igw\_firewall\_pending\_changes) | An list of object containing the fields, 'droplet\_id', 'removing', and 'status'. It is provided to detail exactly which Droplets are having their security policies updated. When empty, all changes have been successfully applied. |
| <a name="output_igw_firewall_status"></a> [igw\_firewall\_status](#output\_igw\_firewall\_status) | A status string indicating the current state of the Firewall. This can be 'waiting', 'succeeded', or 'failed'. |
| <a name="output_igw_firewall_tags"></a> [igw\_firewall\_tags](#output\_igw\_firewall\_tags) | The names of the Tags assigned to the Firewall. |
| <a name="output_igw_volume_description"></a> [igw\_volume\_description](#output\_igw\_volume\_description) | Description of the volume. |
| <a name="output_igw_volume_droplet_ids"></a> [igw\_volume\_droplet\_ids](#output\_igw\_volume\_droplet\_ids) | A list of associated droplet ids. |
| <a name="output_igw_volume_filesystem_label"></a> [igw\_volume\_filesystem\_label](#output\_igw\_volume\_filesystem\_label) | Filesystem label for the block storage volume. |
| <a name="output_igw_volume_filesystem_type"></a> [igw\_volume\_filesystem\_type](#output\_igw\_volume\_filesystem\_type) | Filesystem type (xfs or ext4) for the block storage volume. |
| <a name="output_igw_volume_id"></a> [igw\_volume\_id](#output\_igw\_volume\_id) | The unique identifier for the volume. |
| <a name="output_igw_volume_initial_filesystem_label"></a> [igw\_volume\_initial\_filesystem\_label](#output\_igw\_volume\_initial\_filesystem\_label) | Filesystem label for the block storage volume when it was first created. |
| <a name="output_igw_volume_initial_filesystem_type"></a> [igw\_volume\_initial\_filesystem\_type](#output\_igw\_volume\_initial\_filesystem\_type) | Filesystem type (xfs or ext4) for the block storage volume when it was first created. |
| <a name="output_igw_volume_name"></a> [igw\_volume\_name](#output\_igw\_volume\_name) | Name of the volume. |
| <a name="output_igw_volume_region"></a> [igw\_volume\_region](#output\_igw\_volume\_region) | The region that the volume is created in. |
| <a name="output_igw_volume_snapshot_id"></a> [igw\_volume\_snapshot\_id](#output\_igw\_volume\_snapshot\_id) | The ID of the existing volume snapshot from which this volume was created from. |
| <a name="output_igw_volume_tags"></a> [igw\_volume\_tags](#output\_igw\_volume\_tags) | List of applied tags to the volume. |
| <a name="output_igw_volume_urn"></a> [igw\_volume\_urn](#output\_igw\_volume\_urn) | The uniform resource name for the volume. |
| <a name="output_private_droplet_disk"></a> [private\_droplet\_disk](#output\_private\_droplet\_disk) | The size of the instance's disk in GB |
| <a name="output_private_droplet_id"></a> [private\_droplet\_id](#output\_private\_droplet\_id) | The ID of the Droplet |
| <a name="output_private_droplet_image"></a> [private\_droplet\_image](#output\_private\_droplet\_image) | The image of the Droplet |
| <a name="output_private_droplet_ipv4_address"></a> [private\_droplet\_ipv4\_address](#output\_private\_droplet\_ipv4\_address) | The IPv4 address |
| <a name="output_private_droplet_ipv4_address_private"></a> [private\_droplet\_ipv4\_address\_private](#output\_private\_droplet\_ipv4\_address\_private) | The IPv4 address |
| <a name="output_private_droplet_ipv6"></a> [private\_droplet\_ipv6](#output\_private\_droplet\_ipv6) | Is IPv6 enabled |
| <a name="output_private_droplet_ipv6_address"></a> [private\_droplet\_ipv6\_address](#output\_private\_droplet\_ipv6\_address) | The IPv6 address |
| <a name="output_private_droplet_locked"></a> [private\_droplet\_locked](#output\_private\_droplet\_locked) | The IPv4 address |
| <a name="output_private_droplet_name"></a> [private\_droplet\_name](#output\_private\_droplet\_name) | The name of the Droplet |
| <a name="output_private_droplet_price_hourly"></a> [private\_droplet\_price\_hourly](#output\_private\_droplet\_price\_hourly) | Droplet hourly price |
| <a name="output_private_droplet_price_monthly"></a> [private\_droplet\_price\_monthly](#output\_private\_droplet\_price\_monthly) | Droplet monthly price |
| <a name="output_private_droplet_private_networking"></a> [private\_droplet\_private\_networking](#output\_private\_droplet\_private\_networking) | Is private networking enabled |
| <a name="output_private_droplet_region"></a> [private\_droplet\_region](#output\_private\_droplet\_region) | The region of the Droplet |
| <a name="output_private_droplet_size"></a> [private\_droplet\_size](#output\_private\_droplet\_size) | The instance size |
| <a name="output_private_droplet_status"></a> [private\_droplet\_status](#output\_private\_droplet\_status) | The status of the Droplet |
| <a name="output_private_droplet_tags"></a> [private\_droplet\_tags](#output\_private\_droplet\_tags) | The tags associated with the Droplet |
| <a name="output_private_droplet_urn"></a> [private\_droplet\_urn](#output\_private\_droplet\_urn) | The uniform resource name of the Droplet |
| <a name="output_private_droplet_vcpus"></a> [private\_droplet\_vcpus](#output\_private\_droplet\_vcpus) | The number of the instance's virtual CPUs |
| <a name="output_private_droplet_volume_ids"></a> [private\_droplet\_volume\_ids](#output\_private\_droplet\_volume\_ids) | A list of the attached block storage volumes |
| <a name="output_private_firewall_created_at"></a> [private\_firewall\_created\_at](#output\_private\_firewall\_created\_at) | A time value given in ISO8601 combined date and time format that represents when the Firewall was created. |
| <a name="output_private_firewall_droplet_ids"></a> [private\_firewall\_droplet\_ids](#output\_private\_firewall\_droplet\_ids) | The list of the IDs of the Droplets assigned to the Firewall. |
| <a name="output_private_firewall_id"></a> [private\_firewall\_id](#output\_private\_firewall\_id) | A unique ID that can be used to identify and reference a Firewall. |
| <a name="output_private_firewall_name"></a> [private\_firewall\_name](#output\_private\_firewall\_name) | The name of the Firewall. |
| <a name="output_private_firewall_pending_changes"></a> [private\_firewall\_pending\_changes](#output\_private\_firewall\_pending\_changes) | An list of object containing the fields, 'droplet\_id', 'removing', and 'status'. It is provided to detail exactly which Droplets are having their security policies updated. When empty, all changes have been successfully applied. |
| <a name="output_private_firewall_status"></a> [private\_firewall\_status](#output\_private\_firewall\_status) | A status string indicating the current state of the Firewall. This can be 'waiting', 'succeeded', or 'failed'. |
| <a name="output_private_firewall_tags"></a> [private\_firewall\_tags](#output\_private\_firewall\_tags) | The names of the Tags assigned to the Firewall. |
| <a name="output_private_volume_description"></a> [private\_volume\_description](#output\_private\_volume\_description) | Description of the volume. |
| <a name="output_private_volume_droplet_ids"></a> [private\_volume\_droplet\_ids](#output\_private\_volume\_droplet\_ids) | A list of associated droplet ids. |
| <a name="output_private_volume_filesystem_label"></a> [private\_volume\_filesystem\_label](#output\_private\_volume\_filesystem\_label) | Filesystem label for the block storage volume. |
| <a name="output_private_volume_filesystem_type"></a> [private\_volume\_filesystem\_type](#output\_private\_volume\_filesystem\_type) | Filesystem type (xfs or ext4) for the block storage volume. |
| <a name="output_private_volume_id"></a> [private\_volume\_id](#output\_private\_volume\_id) | The unique identifier for the volume. |
| <a name="output_private_volume_initial_filesystem_label"></a> [private\_volume\_initial\_filesystem\_label](#output\_private\_volume\_initial\_filesystem\_label) | Filesystem label for the block storage volume when it was first created. |
| <a name="output_private_volume_initial_filesystem_type"></a> [private\_volume\_initial\_filesystem\_type](#output\_private\_volume\_initial\_filesystem\_type) | Filesystem type (xfs or ext4) for the block storage volume when it was first created. |
| <a name="output_private_volume_name"></a> [private\_volume\_name](#output\_private\_volume\_name) | Name of the volume. |
| <a name="output_private_volume_region"></a> [private\_volume\_region](#output\_private\_volume\_region) | The region that the volume is created in. |
| <a name="output_private_volume_snapshot_id"></a> [private\_volume\_snapshot\_id](#output\_private\_volume\_snapshot\_id) | The ID of the existing volume snapshot from which this volume was created from. |
| <a name="output_private_volume_tags"></a> [private\_volume\_tags](#output\_private\_volume\_tags) | List of applied tags to the volume. |
| <a name="output_private_volume_urn"></a> [private\_volume\_urn](#output\_private\_volume\_urn) | The uniform resource name for the volume. |
| <a name="output_vpc_created_at"></a> [vpc\_created\_at](#output\_vpc\_created\_at) | The date and time of when the VPC was created. |
| <a name="output_vpc_default"></a> [vpc\_default](#output\_vpc\_default) | A boolean indicating whether or not the VPC is the default one for the region. |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The unique identifier for the VPC. |
| <a name="output_vpc_urn"></a> [vpc\_urn](#output\_vpc\_urn) | The uniform resource name (URN) for the VPC. |
