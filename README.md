<div align="center">
  <h3>terraform-digitalocean-droplet</h3>
  <p>Terraform module to build a Digitalocean droplet</p>
  <p>
    <!-- Build Status -->
    <a href="https://actions-badge.atrox.dev/hansohn/terraform-digitalocean-droplet/goto?ref=main">
      <img src="https://img.shields.io/endpoint.svg?url=https%3A%2F%2Factions-badge.atrox.dev%2Fhansohn%2Fterraform-digitalocean-droplet%2Fbadge%3Fref%3Dmain&style=for-the-badge">
    </a>
    <!-- Github Tag -->
    <a href="https://gitHub.com/hansohn/terraform-digitalocean-droplet/tags/">
      <img src="https://img.shields.io/github/tag/hansohn/terraform-digitalocean-droplet.svg?style=for-the-badge">
    </a>
    <!-- License -->
    <a href="https://github.com/hansohn/terraform-digitalocean-droplet/blob/main/LICENSE">
      <img src="https://img.shields.io/github/license/hansohn/terraform-digitalocean-droplet.svg?style=for-the-badge">
    </a>
    <!-- LinkedIn -->
    <a href="https://linkedin.com/in/ryanhansohn">
      <img src="https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555">
    </a>
  </p>
</div>

## :open_book: Usage

Welcome to the terraform-digitalocean-droplet repo!


### Makefile

I've included the following make targets for convenience:

```
Available targets:

  clean                               Clean everything
  clean/docker                        Clean docker build images
  clean/terraform                     Clean terraform generated files/directories
  docker                              Docker lint, build and run image
  docker/run                          Docker run image
  help                                Help screen
  help/all                            Display help for all targets
  help/short                          This help short screen
```

## :octocat: Examples

Please see the sample set of examples below for a better understanding of implementation

- [Complete](examples/complete) - Complete Example

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_cloudinit"></a> [cloudinit](#requirement\_cloudinit) | >= 2.0.0 |
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | >= 2.0.0 |
| <a name="requirement_http"></a> [http](#requirement\_http) | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudinit"></a> [cloudinit](#provider\_cloudinit) | >= 2.0.0 |
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | >= 2.0.0 |
| <a name="provider_http"></a> [http](#provider\_http) | >= 3.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_igw_label"></a> [igw\_label](#module\_igw\_label) | cloudposse/label/null | 0.25.0 |
| <a name="module_private_label"></a> [private\_label](#module\_private\_label) | cloudposse/label/null | 0.25.0 |
| <a name="module_public_label"></a> [public\_label](#module\_public\_label) | cloudposse/label/null | 0.25.0 |
| <a name="module_ssh_key"></a> [ssh\_key](#module\_ssh\_key) | ./modules/ssh-key | n/a |
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.25.0 |

## Resources

| Name | Type |
|------|------|
| [digitalocean_droplet.igw](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet) | resource |
| [digitalocean_droplet.private](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet) | resource |
| [digitalocean_firewall.private](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/firewall) | resource |
| [digitalocean_firewall.public](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/firewall) | resource |
| [digitalocean_floating_ip.igw](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/floating_ip) | resource |
| [digitalocean_floating_ip_assignment.igw](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/floating_ip_assignment) | resource |
| [digitalocean_loadbalancer.public](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/loadbalancer) | resource |
| [digitalocean_project.this](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/project) | resource |
| [digitalocean_project_resources.igw_droplet](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/project_resources) | resource |
| [digitalocean_project_resources.igw_droplet_volume](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/project_resources) | resource |
| [digitalocean_project_resources.igw_floating_ip](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/project_resources) | resource |
| [digitalocean_project_resources.private_droplet](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/project_resources) | resource |
| [digitalocean_project_resources.private_droplet_voluem](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/project_resources) | resource |
| [digitalocean_volume.igw](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/volume) | resource |
| [digitalocean_volume.private](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/volume) | resource |
| [digitalocean_volume_attachment.igw](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/volume_attachment) | resource |
| [digitalocean_volume_attachment.private](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/volume_attachment) | resource |
| [digitalocean_vpc.this](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/vpc) | resource |
| [cloudinit_config.igw](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config) | data source |
| [cloudinit_config.private](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config) | data source |
| [http_http.myip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br>This is for some rare cases where resources want additional configuration of tags<br>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_algorithm"></a> [algorithm](#input\_algorithm) | SSH key algorithm | `string` | `"RSA"` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "descriptor_formats": {},<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "labels_as_tags": [<br>    "unset"<br>  ],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {},<br>  "tenant": null<br>}</pre> | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br>Map of maps. Keys are names of descriptors. Values are maps of the form<br>`{<br>   format = string<br>   labels = list(string)<br>}`<br>(Type is `any` so the map values can later be enhanced to provide additional options.)<br>`format` is a Terraform format string to be passed to the `format()` function.<br>`labels` is a list of labels, in order, to pass to `format()` function.<br>Label values will be normalized before being passed to `format()` so they will be<br>identical to how they appear in `id`.<br>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_ecdsa_curve"></a> [ecdsa\_curve](#input\_ecdsa\_curve) | (Optional) When algorithm is 'ECDSA', the name of the elliptic curve to use. May be any one of 'P224', 'P256', 'P384' or 'P521', with 'P224' as the default. | `string` | `null` | no |
| <a name="input_enable_internet_gateway"></a> [enable\_internet\_gateway](#input\_enable\_internet\_gateway) | (Optional) Enable creation of Internet Gateway resources. Defaults to true. | `bool` | `true` | no |
| <a name="input_enable_project"></a> [enable\_project](#input\_enable\_project) | (Optional) A boolean flag to enable/disable Project resource creation. Defaults to true. | `bool` | `true` | no |
| <a name="input_enable_public_lb"></a> [enable\_public\_lb](#input\_enable\_public\_lb) | (Optional) A boolean flag to enable/disable Load Balancer resource creation. Defaults to false. | `bool` | `false` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_firewall_allow_myip_ssh"></a> [firewall\_allow\_myip\_ssh](#input\_firewall\_allow\_myip\_ssh) | (Optional) Allow your external ip ssh inbound permissions to the internet gateway. | `bool` | `false` | no |
| <a name="input_firewall_allow_myip_web"></a> [firewall\_allow\_myip\_web](#input\_firewall\_allow\_myip\_web) | (Optional) Allow your external ip port 80/443 inbound permissions to the private droplets. | `bool` | `false` | no |
| <a name="input_generate_ssh_key"></a> [generate\_ssh\_key](#input\_generate\_ssh\_key) | If set to `true`, new SSH key pair will be created and `ssh_public_key_file` will be ignored. Conflicts with ssh\_public\_key\_file | `bool` | `false` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for keep the existing setting, which defaults to `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_igw_droplet_backups"></a> [igw\_droplet\_backups](#input\_igw\_droplet\_backups) | (Optional) Boolean controlling if backups are made. Defaults to false. | `bool` | `null` | no |
| <a name="input_igw_droplet_cloudinit_parts"></a> [igw\_droplet\_cloudinit\_parts](#input\_igw\_droplet\_cloudinit\_parts) | (Optional) List of nested block types which adds a file to the generated cloud-init configuration. Use multiple part blocks to specify multiple files, which will be included in order of declaration in the final MIME document. | `list(any)` | `[]` | no |
| <a name="input_igw_droplet_enable_bastion"></a> [igw\_droplet\_enable\_bastion](#input\_igw\_droplet\_enable\_bastion) | (Optional) Boolean controlling whether to enable bastion ssh feature on droplet | `bool` | `false` | no |
| <a name="input_igw_droplet_enable_notifications"></a> [igw\_droplet\_enable\_notifications](#input\_igw\_droplet\_enable\_notifications) | (Optional) Boolean controlling whether to enable slack notifications. Currently this feature only applies to bastion fail2ban sshd jail notifications. | `bool` | `false` | no |
| <a name="input_igw_droplet_image"></a> [igw\_droplet\_image](#input\_igw\_droplet\_image) | (Required) The Droplet image ID or slug. | `string` | `null` | no |
| <a name="input_igw_droplet_ipv6"></a> [igw\_droplet\_ipv6](#input\_igw\_droplet\_ipv6) | (Optional) Boolean controlling if IPv6 is enabled. Defaults to false. | `bool` | `null` | no |
| <a name="input_igw_droplet_monitoring"></a> [igw\_droplet\_monitoring](#input\_igw\_droplet\_monitoring) | (Optional) Boolean controlling whether monitoring agent is installed. Defaults to false. | `bool` | `true` | no |
| <a name="input_igw_droplet_name"></a> [igw\_droplet\_name](#input\_igw\_droplet\_name) | (Required) The Droplet name. | `string` | `null` | no |
| <a name="input_igw_droplet_resize_disk"></a> [igw\_droplet\_resize\_disk](#input\_igw\_droplet\_resize\_disk) | (Optional) Boolean controlling whether to increase the disk size when resizing a Droplet. It defaults to true. When set to false, only the Droplet's RAM and CPU will be resized. Increasing a Droplet's disk size is a permanent change. Increasing only RAM and CPU is reversible. | `bool` | `null` | no |
| <a name="input_igw_droplet_size"></a> [igw\_droplet\_size](#input\_igw\_droplet\_size) | (Required) The unique slug that indentifies the type of Droplet. | `string` | `"s-1vcpu-1gb"` | no |
| <a name="input_igw_droplet_ssh_keys"></a> [igw\_droplet\_ssh\_keys](#input\_igw\_droplet\_ssh\_keys) | (Optional) A list of SSH IDs or fingerprints to enable in the format [12345, 123456]. | `list(string)` | `[]` | no |
| <a name="input_igw_droplet_tags"></a> [igw\_droplet\_tags](#input\_igw\_droplet\_tags) | (Optional) A list of the tags to be applied to this Droplet. | `list(string)` | `[]` | no |
| <a name="input_igw_droplet_volume_ids"></a> [igw\_droplet\_volume\_ids](#input\_igw\_droplet\_volume\_ids) | (Optional) - A list of the IDs of each block storage volume to be attached to the Droplet. | `list(string)` | `null` | no |
| <a name="input_igw_volume_description"></a> [igw\_volume\_description](#input\_igw\_volume\_description) | (Optional) A free-form text field up to a limit of 1024 bytes to describe a block storage volume. | `string` | `null` | no |
| <a name="input_igw_volume_enabled"></a> [igw\_volume\_enabled](#input\_igw\_volume\_enabled) | Boolean controlling whether a volume will be created and attached to the internet gateway instnace | `bool` | `false` | no |
| <a name="input_igw_volume_initial_filesystem_label"></a> [igw\_volume\_initial\_filesystem\_label](#input\_igw\_volume\_initial\_filesystem\_label) | (Optional) Initial filesystem label for the block storage volume. | `string` | `null` | no |
| <a name="input_igw_volume_initial_filesystem_type"></a> [igw\_volume\_initial\_filesystem\_type](#input\_igw\_volume\_initial\_filesystem\_type) | (Optional) Initial filesystem type (xfs or ext4) for the block storage volume. | `string` | `null` | no |
| <a name="input_igw_volume_name"></a> [igw\_volume\_name](#input\_igw\_volume\_name) | (Required) A name for the block storage volume. Must be lowercase and be composed only of numbers, letters and '-', up to a limit of 64 characters. | `string` | `null` | no |
| <a name="input_igw_volume_size"></a> [igw\_volume\_size](#input\_igw\_volume\_size) | (Required) The size of the block storage volume in GiB. If updated, can only be expanded. | `number` | `null` | no |
| <a name="input_igw_volume_snapshot_id"></a> [igw\_volume\_snapshot\_id](#input\_igw\_volume\_snapshot\_id) | (Optional) The ID of an existing volume snapshot from which the new volume will be created. If supplied, the region and size will be limitied on creation to that of the referenced snapshot | `string` | `null` | no |
| <a name="input_igw_volume_tags"></a> [igw\_volume\_tags](#input\_igw\_volume\_tags) | (Optional) A list of the tags to be applied to this Volume. | `list(string)` | `[]` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br>Does not affect keys of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br>set as tag values, and output by this module individually.<br>Does not affect values of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br>Default is to include all labels.<br>Tags with empty values will not be included in the `tags` output.<br>Set to `[]` to suppress all generated tags.<br>**Notes:**<br>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_local_download_enabled"></a> [local\_download\_enabled](#input\_local\_download\_enabled) | (Optional) If generate\_ssh\_key enabled, the key pair will be downloaded locally to the ssh\_key\_path | `bool` | `true` | no |
| <a name="input_local_ssh_key_path"></a> [local\_ssh\_key\_path](#input\_local\_ssh\_key\_path) | Path to local SSH public key directory (e.g. `/secrets`) | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_private_droplet_backups"></a> [private\_droplet\_backups](#input\_private\_droplet\_backups) | (Optional) Boolean controlling if backups are made. Defaults to false. | `bool` | `null` | no |
| <a name="input_private_droplet_cloudinit_parts"></a> [private\_droplet\_cloudinit\_parts](#input\_private\_droplet\_cloudinit\_parts) | (Optional) List of nested block types which adds a file to the generated cloud-init configuration. Use multiple part blocks to specify multiple files, which will be included in order of declaration in the final MIME document. | `list(any)` | `[]` | no |
| <a name="input_private_droplet_count"></a> [private\_droplet\_count](#input\_private\_droplet\_count) | (Optional) Number of private droplet instances to create. Defauts to 1. | `number` | `1` | no |
| <a name="input_private_droplet_image"></a> [private\_droplet\_image](#input\_private\_droplet\_image) | (Required) The Droplet image ID or slug. | `string` | `null` | no |
| <a name="input_private_droplet_ipv6"></a> [private\_droplet\_ipv6](#input\_private\_droplet\_ipv6) | (Optional) Boolean controlling if IPv6 is enabled. Defaults to false. | `bool` | `null` | no |
| <a name="input_private_droplet_monitoring"></a> [private\_droplet\_monitoring](#input\_private\_droplet\_monitoring) | (Optional) Boolean controlling whether monitoring agent is installed. Defaults to false. | `bool` | `null` | no |
| <a name="input_private_droplet_name"></a> [private\_droplet\_name](#input\_private\_droplet\_name) | (Required) The Droplet name. | `string` | `null` | no |
| <a name="input_private_droplet_resize_disk"></a> [private\_droplet\_resize\_disk](#input\_private\_droplet\_resize\_disk) | (Optional) Boolean controlling whether to increase the disk size when resizing a Droplet. It defaults to true. When set to false, only the Droplet's RAM and CPU will be resized. Increasing a Droplet's disk size is a permanent change. Increasing only RAM and CPU is reversible. | `bool` | `null` | no |
| <a name="input_private_droplet_size"></a> [private\_droplet\_size](#input\_private\_droplet\_size) | (Required) The unique slug that indentifies the type of Droplet. | `string` | `"s-1vcpu-1gb"` | no |
| <a name="input_private_droplet_ssh_keys"></a> [private\_droplet\_ssh\_keys](#input\_private\_droplet\_ssh\_keys) | (Optional) A list of SSH IDs or fingerprints to enable in the format [12345, 123456]. | `list(string)` | `[]` | no |
| <a name="input_private_droplet_tags"></a> [private\_droplet\_tags](#input\_private\_droplet\_tags) | (Optional) A list of the tags to be applied to this Droplet. | `list(string)` | `[]` | no |
| <a name="input_private_droplet_volume_ids"></a> [private\_droplet\_volume\_ids](#input\_private\_droplet\_volume\_ids) | (Optional) - A list of the IDs of each block storage volume to be attached to the Droplet. | `list(string)` | `null` | no |
| <a name="input_private_firewall_inbound_rules"></a> [private\_firewall\_inbound\_rules](#input\_private\_firewall\_inbound\_rules) | (Optional) The inbound access rule block for the Firewall. | `list(any)` | `[]` | no |
| <a name="input_private_firewall_name"></a> [private\_firewall\_name](#input\_private\_firewall\_name) | (Required) The Firewall name | `string` | `null` | no |
| <a name="input_private_firewall_outbound_rules"></a> [private\_firewall\_outbound\_rules](#input\_private\_firewall\_outbound\_rules) | (Optional) The outbound access rule block for the Firewall. | `list(any)` | `[]` | no |
| <a name="input_private_firewall_tags"></a> [private\_firewall\_tags](#input\_private\_firewall\_tags) | (Optional) - The names of the Tags assigned to the Firewall. | `list(string)` | <pre>[<br>  "private"<br>]</pre> | no |
| <a name="input_private_volume_description"></a> [private\_volume\_description](#input\_private\_volume\_description) | (Optional) A free-form text field up to a limit of 1024 bytes to describe a block storage volume. | `string` | `null` | no |
| <a name="input_private_volume_enabled"></a> [private\_volume\_enabled](#input\_private\_volume\_enabled) | Boolean controlling whether a volume will be created and attached to the private instnace(s) | `bool` | `false` | no |
| <a name="input_private_volume_initial_filesystem_label"></a> [private\_volume\_initial\_filesystem\_label](#input\_private\_volume\_initial\_filesystem\_label) | (Optional) Initial filesystem label for the block storage volume. | `string` | `null` | no |
| <a name="input_private_volume_initial_filesystem_type"></a> [private\_volume\_initial\_filesystem\_type](#input\_private\_volume\_initial\_filesystem\_type) | (Optional) Initial filesystem type (xfs or ext4) for the block storage volume. | `string` | `null` | no |
| <a name="input_private_volume_name"></a> [private\_volume\_name](#input\_private\_volume\_name) | (Required) A name for the block storage volume. Must be lowercase and be composed only of numbers, letters and '-', up to a limit of 64 characters. | `string` | `null` | no |
| <a name="input_private_volume_size"></a> [private\_volume\_size](#input\_private\_volume\_size) | (Required) The size of the block storage volume in GiB. If updated, can only be expanded. | `number` | `null` | no |
| <a name="input_private_volume_snapshot_id"></a> [private\_volume\_snapshot\_id](#input\_private\_volume\_snapshot\_id) | (Optional) The ID of an existing volume snapshot from which the new volume will be created. If supplied, the region and size will be limitied on creation to that of the referenced snapshot | `string` | `null` | no |
| <a name="input_private_volume_tags"></a> [private\_volume\_tags](#input\_private\_volume\_tags) | (Optional) A list of the tags to be applied to this Volume. | `list(string)` | `[]` | no |
| <a name="input_project_description"></a> [project\_description](#input\_project\_description) | (Optional) the description of the project | `string` | `"A project to represent development resources."` | no |
| <a name="input_project_environment"></a> [project\_environment](#input\_project\_environment) | (Optional) the environment of the project's resources. The possible values are: Development, Staging, Production) | `string` | `"Development"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | (Optional) The name of the Project | `string` | `"playground"` | no |
| <a name="input_project_purpose"></a> [project\_purpose](#input\_project\_purpose) | (Optional) the purpose of the project, (Default: 'Web Application') | `string` | `"Web Application"` | no |
| <a name="input_public_firewall_inbound_rules"></a> [public\_firewall\_inbound\_rules](#input\_public\_firewall\_inbound\_rules) | (Optional) The inbound access rule block for the Firewall. | `list(any)` | `[]` | no |
| <a name="input_public_firewall_name"></a> [public\_firewall\_name](#input\_public\_firewall\_name) | (Required) The Firewall name | `string` | `null` | no |
| <a name="input_public_firewall_outbound_rules"></a> [public\_firewall\_outbound\_rules](#input\_public\_firewall\_outbound\_rules) | (Optional) The outbound access rule block for the Firewall. | `list(any)` | `[]` | no |
| <a name="input_public_firewall_tags"></a> [public\_firewall\_tags](#input\_public\_firewall\_tags) | (Optional) - The names of the Tags assigned to the Firewall. | `list(string)` | <pre>[<br>  "igw"<br>]</pre> | no |
| <a name="input_public_lb_algorithm"></a> [public\_lb\_algorithm](#input\_public\_lb\_algorithm) | (Optional) The load balancing algorithm used to determine which backend Droplet will be selected by a client. It must be either round\_robin or least\_connections. The default value is round\_robin. | `string` | `null` | no |
| <a name="input_public_lb_disable_lets_encrypt_dns_records"></a> [public\_lb\_disable\_lets\_encrypt\_dns\_records](#input\_public\_lb\_disable\_lets\_encrypt\_dns\_records) | (Optional) A boolean value indicating whether to disable automatic DNS record creation for Let's Encrypt certificates that are added to the load balancer. Default value is false. | `bool` | `null` | no |
| <a name="input_public_lb_droplet_ids"></a> [public\_lb\_droplet\_ids](#input\_public\_lb\_droplet\_ids) | (Optional) - A list of the IDs of each droplet to be attached to the Load Balancer. | `list(string)` | `null` | no |
| <a name="input_public_lb_droplet_tag"></a> [public\_lb\_droplet\_tag](#input\_public\_lb\_droplet\_tag) | (Optional) - A list of the IDs of each droplet to be attached to the Load Balancer. | `string` | `null` | no |
| <a name="input_public_lb_enable_backend_keepalive"></a> [public\_lb\_enable\_backend\_keepalive](#input\_public\_lb\_enable\_backend\_keepalive) | (Optional) A boolean value indicating whether HTTP keepalive connections are maintained to target Droplets. Default value is false. | `bool` | `null` | no |
| <a name="input_public_lb_enable_proxy_protocol"></a> [public\_lb\_enable\_proxy\_protocol](#input\_public\_lb\_enable\_proxy\_protocol) | (Optional) A boolean value indicating whether PROXY Protocol should be used to pass information from connecting client requests to the backend service. Default value is false. | `bool` | `null` | no |
| <a name="input_public_lb_firewall_allow"></a> [public\_lb\_firewall\_allow](#input\_public\_lb\_firewall\_allow) | (Optional) A list of strings describing allow rules. Must be colon delimited strings of the form {type}:{source} | `list(string)` | `[]` | no |
| <a name="input_public_lb_firewall_deny"></a> [public\_lb\_firewall\_deny](#input\_public\_lb\_firewall\_deny) | (Optional) A list of strings describing deny rules. Must be colon delimited strings of the form {type}:{source} | `list(string)` | `[]` | no |
| <a name="input_public_lb_forwarding_rule"></a> [public\_lb\_forwarding\_rule](#input\_public\_lb\_forwarding\_rule) | (Required) A list of forwarding\_rule to be assigned to the Load Balancer. The forwarding\_rule block is documented below. | `list(any)` | `[]` | no |
| <a name="input_public_lb_healthcheck"></a> [public\_lb\_healthcheck](#input\_public\_lb\_healthcheck) | (Optional) A healthcheck block to be assigned to the Load Balancer. The healthcheck block is documented below. Only 1 healthcheck is allowed. | `list(any)` | `[]` | no |
| <a name="input_public_lb_http_idle_timeout_seconds"></a> [public\_lb\_http\_idle\_timeout\_seconds](#input\_public\_lb\_http\_idle\_timeout\_seconds) | (Optional) Specifies the idle timeout for HTTPS connections on the load balancer in seconds. | `number` | `null` | no |
| <a name="input_public_lb_name"></a> [public\_lb\_name](#input\_public\_lb\_name) | (Required) The Load Balancer name. | `string` | `null` | no |
| <a name="input_public_lb_project_id"></a> [public\_lb\_project\_id](#input\_public\_lb\_project\_id) | (Optional) The ID of the project that the load balancer is associated with. If no ID is provided at creation, the load balancer associates with the user's default project. | `string` | `null` | no |
| <a name="input_public_lb_redirect_http_to_https"></a> [public\_lb\_redirect\_http\_to\_https](#input\_public\_lb\_redirect\_http\_to\_https) | (Optional) A boolean value indicating whether HTTP requests to the Load Balancer on port 80 will be redirected to HTTPS on port 443. Default value is false. | `bool` | `null` | no |
| <a name="input_public_lb_size"></a> [public\_lb\_size](#input\_public\_lb\_size) | (Optional) The size of the Load Balancer. It must be either lb-small, lb-medium, or lb-large. Defaults to lb-small. Only one of size or size\_unit may be provided. | `string` | `null` | no |
| <a name="input_public_lb_size_unit"></a> [public\_lb\_size\_unit](#input\_public\_lb\_size\_unit) | (Optional) The size of the Load Balancer. It must be in the range (1, 100). Defaults to 1. Only one of size or size\_unit may be provided. | `number` | `null` | no |
| <a name="input_public_lb_sticky_sessions"></a> [public\_lb\_sticky\_sessions](#input\_public\_lb\_sticky\_sessions) | (Optional) A sticky\_sessions block to be assigned to the Load Balancer. The sticky\_sessions block is documented below. Only 1 sticky\_sessions block is allowed. | `list(any)` | `[]` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br>Characters matching the regex will be removed from the ID elements.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_rsa_bits"></a> [rsa\_bits](#input\_rsa\_bits) | (Optional) When algorithm is 'RSA', the size of the generated RSA key in bits. Defaults to 2048. | `number` | `null` | no |
| <a name="input_slack_channel"></a> [slack\_channel](#input\_slack\_channel) | (Optional) The name of the channel to be used as the destination for webhook messages. | `string` | `""` | no |
| <a name="input_slack_icon"></a> [slack\_icon](#input\_slack\_icon) | (Optional) Slack emoji icon to used for notifications. | `string` | `""` | no |
| <a name="input_slack_username"></a> [slack\_username](#input\_slack\_username) | (Optional) Slack username to post on behalf of for notifications. | `string` | `""` | no |
| <a name="input_slack_webhook_url"></a> [slack\_webhook\_url](#input\_slack\_webhook\_url) | (Optional) The Incoming Webhook URL | `string` | `""` | no |
| <a name="input_ssh_key_name"></a> [ssh\_key\_name](#input\_ssh\_key\_name) | If ssh\_public\_key\_file and generate\_ssh\_key are undefined, the name of existing DigitalOcean ssh key to utilize. If ssh\_public\_key\_file or generate\_ssh\_key are defined, the name to be assoicated with the ssh key in DigitalOcean | `string` | `null` | no |
| <a name="input_ssh_public_key_file"></a> [ssh\_public\_key\_file](#input\_ssh\_public\_key\_file) | Filename (including path) of existing SSH public key file (e.g. `/path/to/id_rsa.pub`). Confilcts with generate\_ssh\_key. | `string` | `null` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |
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
| <a name="output_public_firewall_created_at"></a> [public\_firewall\_created\_at](#output\_public\_firewall\_created\_at) | A time value given in ISO8601 combined date and time format that represents when the Firewall was created. |
| <a name="output_public_firewall_droplet_ids"></a> [public\_firewall\_droplet\_ids](#output\_public\_firewall\_droplet\_ids) | The list of the IDs of the Droplets assigned to the Firewall. |
| <a name="output_public_firewall_id"></a> [public\_firewall\_id](#output\_public\_firewall\_id) | A unique ID that can be used to identify and reference a Firewall. |
| <a name="output_public_firewall_name"></a> [public\_firewall\_name](#output\_public\_firewall\_name) | The name of the Firewall. |
| <a name="output_public_firewall_pending_changes"></a> [public\_firewall\_pending\_changes](#output\_public\_firewall\_pending\_changes) | An list of object containing the fields, 'droplet\_id', 'removing', and 'status'. It is provided to detail exactly which Droplets are having their security policies updated. When empty, all changes have been successfully applied. |
| <a name="output_public_firewall_status"></a> [public\_firewall\_status](#output\_public\_firewall\_status) | A status string indicating the current state of the Firewall. This can be 'waiting', 'succeeded', or 'failed'. |
| <a name="output_public_firewall_tags"></a> [public\_firewall\_tags](#output\_public\_firewall\_tags) | The names of the Tags assigned to the Firewall. |
| <a name="output_vpc_created_at"></a> [vpc\_created\_at](#output\_vpc\_created\_at) | The date and time of when the VPC was created. |
| <a name="output_vpc_default"></a> [vpc\_default](#output\_vpc\_default) | A boolean indicating whether or not the VPC is the default one for the region. |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The unique identifier for the VPC. |
| <a name="output_vpc_urn"></a> [vpc\_urn](#output\_vpc\_urn) | The uniform resource name (URN) for the VPC. |
<!-- END_TF_DOCS -->
