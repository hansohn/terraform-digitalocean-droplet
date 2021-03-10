#--------------------------------------------------------------
# Provider
#--------------------------------------------------------------

variable "do_token" {
  type = string
  default = null
  description = "(Required) This is the DO API token. Alternatively, this can also be specified using environment variables ordered by precedence; DIGITALOCEAN_TOKEN, DIGITALOCEAN_ACCESS_TOKEN."
}

#--------------------------------------------------------------
# SSH-Key
#--------------------------------------------------------------

variable "ssh_key_name" {
  type = string
  default = null
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
# Security Groups
#--------------------------------------------------------------

variable "remote_access_ips" {
  type = list(string)
  default = ["0.0.0.0/0"]
  description = "List of external ips to be granted ssh access to public facing droplets"
}

#--------------------------------------------------------------
# Internet Gateway Droplet
#--------------------------------------------------------------

variable "igw_droplet_enable_bastion" {
  type = bool
  default = false
  description = "(Optional) Boolean controlling whether to enable bastion ssh feature on droplet"
}

variable "igw_droplet_enable_notifications" {
  type = bool
  default = false
  description = "(Optional) Boolean controlling whether to enable slack notifications. Currently this feature only applies to bastion fail2ban sshd jail notifications."
}

#--------------------------------------------------------------
# Slack Notifications
#--------------------------------------------------------------

variable "slack_channel" {
  type = string
  default = ""
  description = "(Optional) The name of the channel to be used as the destination for webhook messages."
}

variable "slack_username" {
  type = string
  default = ""
  description = "(Optional) Slack username to post on behalf of for notifications."
}

variable "slack_icon" {
  type = string
  default = ""
  description = "(Optional) Slack emoji icon to used for notifications."
}

variable "slack_webhook_url" {
  type = string
  default = ""
  description = "(Optional) The Incoming Webhook URL"
}
