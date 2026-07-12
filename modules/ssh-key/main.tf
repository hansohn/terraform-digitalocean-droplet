################################################################################
# SSH-Key
################################################################################

locals {
  # Base path for the downloaded key pair, e.g. ~/.ssh/<name>-rsa
  key_filename = "${pathexpand(var.local_ssh_key_path)}/${var.name}-${lower(var.algorithm)}"
}

# refference existing key
data "digitalocean_ssh_key" "referenced" {
  count = var.enabled && !var.generate_ssh_key && var.ssh_public_key_file == null ? 1 : 0
  name  = var.ssh_key_name
}

# import existing key
resource "digitalocean_ssh_key" "imported" {
  count      = var.enabled && !var.generate_ssh_key && var.ssh_public_key_file != null ? 1 : 0
  name       = coalesce(var.ssh_key_name, var.name)
  public_key = file(pathexpand(var.ssh_public_key_file))
}

# generate keys
resource "tls_private_key" "generated" {
  count       = var.enabled && var.generate_ssh_key ? 1 : 0
  algorithm   = var.algorithm
  rsa_bits    = var.rsa_bits
  ecdsa_curve = var.ecdsa_curve
}

resource "digitalocean_ssh_key" "generated" {
  count      = var.enabled && var.generate_ssh_key ? 1 : 0
  name       = coalesce(var.ssh_key_name, var.name)
  public_key = tls_private_key.generated[0].public_key_openssh
}

resource "local_file" "public_key" {
  count           = var.enabled && var.generate_ssh_key && var.local_download_enabled ? 1 : 0
  content         = tls_private_key.generated[0].public_key_openssh
  filename        = "${local.key_filename}.pub"
  file_permission = "0644"
}

resource "local_sensitive_file" "private_key" {
  count           = var.enabled && var.generate_ssh_key && var.local_download_enabled ? 1 : 0
  content         = tls_private_key.generated[0].private_key_pem
  filename        = local.key_filename
  file_permission = "0600"
}
