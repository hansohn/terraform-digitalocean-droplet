#--------------------------------------------------------------
# Labeling
#--------------------------------------------------------------

module "label" {
  source              = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.19.2"
  additional_tag_map  = var.additional_tag_map
  attributes          = var.attributes
  context             = var.context
  delimiter           = var.delimiter
  enabled             = var.enabled
  environment         = var.environment
  id_length_limit     = var.id_length_limit
  label_order         = var.label_order
  name                = var.name
  namespace           = var.namespace
  regex_replace_chars = var.regex_replace_chars
  stage               = var.stage
  tags                = var.tags
}

#--------------------------------------------------------------
# SSH-Key
#--------------------------------------------------------------

# refference existing key
data "digitalocean_ssh_key" "referenced" {
  count = module.label.enabled && ! var.generate_ssh_key && var.ssh_public_key_file == null ? 1 : 0
  name = var.ssh_key_name
}

# import existing key
resource "digitalocean_ssh_key" "imported" {
  count = module.label.enabled && ! var.generate_ssh_key &&  var.ssh_public_key_file != null ? 1 : 0
  name = var.ssh_key_name != null ? var.ssh_key_name : module.label.id
  public_key = file(pathexpand(var.ssh_public_key_file))
}

# generate keys
resource "tls_private_key" "generated" {
  count = module.label.enabled && var.generate_ssh_key ? 1 : 0
  algorithm = var.algorithm
  rsa_bits = var.rsa_bits
  ecdsa_curve = var.ecdsa_curve
}

resource "digitalocean_ssh_key" "generated" {
  count = module.label.enabled && var.generate_ssh_key ? 1 : 0
  name = var.ssh_key_name != null ? var.ssh_key_name : module.label.id
  public_key = tls_private_key.generated[0].public_key_openssh
}

resource "local_file" "public_key" {
  count = module.label.enabled && var.generate_ssh_key && var.local_download_enabled ? 1 : 0
  content = tls_private_key.generated[0].public_key_openssh
  filename = format(
    "%s/%s%s%s.pub",
    pathexpand(var.local_ssh_key_path),
    module.label.id,
    module.label.delimiter,
    lower(var.algorithm)
  )
  file_permission = "0644"
}

resource "local_file" "private_key" {
  count = module.label.enabled && var.generate_ssh_key && var.local_download_enabled ? 1 : 0
  sensitive_content = tls_private_key.generated[0].private_key_pem
  filename = format(
    "%s/%s%s%s",
    pathexpand(var.local_ssh_key_path),
    module.label.id,
    module.label.delimiter,
    lower(var.algorithm)
  )
  file_permission = "0600"
}
