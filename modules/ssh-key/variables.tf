################################################################################
# General
################################################################################

variable "enabled" {
  type        = bool
  default     = true
  description = "Set to false to prevent the submodule from creating any resources."
}

variable "name" {
  type        = string
  default     = null
  description = "Base name used for the generated or imported SSH key when ssh_key_name is not set."
}

################################################################################
# SSH Key
################################################################################

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
  description = "If set to `true`, a new SSH key pair is generated and `ssh_public_key_file` is ignored. Conflicts with ssh_public_key_file. WARNING: the generated private key is stored in Terraform state in plaintext (and written to disk when local_download_enabled is true); for production prefer importing a public key via `ssh_public_key_file` or referencing an existing key via `ssh_key_name`."
}

variable "algorithm" {
  type        = string
  default     = "ED25519"
  description = "SSH key algorithm. One of RSA, ECDSA, or ED25519."
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
  description = "(Optional) When generate_ssh_key is true, write the generated key pair to local_ssh_key_path. WARNING: this writes the private key to disk in plaintext."
}

variable "local_ssh_key_path" {
  type        = string
  default     = null
  description = "Path to local SSH public key directory (e.g. `/secrets`)"
}
