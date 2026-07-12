<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_algorithm"></a> [algorithm](#input\_algorithm) | SSH key algorithm | `string` | `"RSA"` | no |
| <a name="input_ecdsa_curve"></a> [ecdsa\_curve](#input\_ecdsa\_curve) | (Optional) When algorithm is 'ECDSA', the name of the elliptic curve to use. May be any one of 'P224', 'P256', 'P384' or 'P521', with 'P224' as the default. | `string` | `null` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the submodule from creating any resources. | `bool` | `true` | no |
| <a name="input_generate_ssh_key"></a> [generate\_ssh\_key](#input\_generate\_ssh\_key) | If set to `true`, new SSH key pair will be created and `ssh_public_key_file` will be ignored. Conflicts with ssh\_public\_key\_file | `bool` | `false` | no |
| <a name="input_local_download_enabled"></a> [local\_download\_enabled](#input\_local\_download\_enabled) | (Optional) If generate\_ssh\_key enabled, the key pair will be downloaded locally to the ssh\_key\_path | `bool` | `true` | no |
| <a name="input_local_ssh_key_path"></a> [local\_ssh\_key\_path](#input\_local\_ssh\_key\_path) | Path to local SSH public key directory (e.g. `/secrets`) | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Base name used for the generated or imported SSH key when ssh\_key\_name is not set. | `string` | `null` | no |
| <a name="input_rsa_bits"></a> [rsa\_bits](#input\_rsa\_bits) | (Optional) When algorithm is 'RSA', the size of the generated RSA key in bits. Defaults to 2048. | `number` | `null` | no |
| <a name="input_ssh_key_name"></a> [ssh\_key\_name](#input\_ssh\_key\_name) | If ssh\_public\_key\_file and generate\_ssh\_key are undefined, the name of existing DigitalOcean ssh key to utilize. If ssh\_public\_key\_file or generate\_ssh\_key are defined, the name to be assoicated with the ssh key in DigitalOcean | `string` | `null` | no |
| <a name="input_ssh_public_key_file"></a> [ssh\_public\_key\_file](#input\_ssh\_public\_key\_file) | Filename (including path) of existing SSH public key file (e.g. `/path/to/id_rsa.pub`). Confilcts with generate\_ssh\_key. | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_key_fingerprint"></a> [key\_fingerprint](#output\_key\_fingerprint) | The fingerprint of the SSH key |
| <a name="output_key_id"></a> [key\_id](#output\_key\_id) | The unique ID of the key |
| <a name="output_key_name"></a> [key\_name](#output\_key\_name) | Name of SSH key |
| <a name="output_private_key"></a> [private\_key](#output\_private\_key) | Content of the generated private key |
| <a name="output_private_key_local_filename"></a> [private\_key\_local\_filename](#output\_private\_key\_local\_filename) | Private Key local filename |
| <a name="output_public_key"></a> [public\_key](#output\_public\_key) | Content of the generated public key |
| <a name="output_public_key_local_filename"></a> [public\_key\_local\_filename](#output\_public\_key\_local\_filename) | Public Key local filename |
<!-- END_TF_DOCS -->