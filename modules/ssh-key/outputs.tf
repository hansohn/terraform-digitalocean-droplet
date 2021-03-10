#--------------------------------------------------------------
# SSH-Key
#--------------------------------------------------------------

output "key_id" {
  value = element(concat(data.digitalocean_ssh_key.referenced.*.id, digitalocean_ssh_key.imported.*.id, digitalocean_ssh_key.generated.*.id), 0)
  description = "The unique ID of the key"
}

output "key_name" {
  value = element(concat(data.digitalocean_ssh_key.referenced.*.name, digitalocean_ssh_key.imported.*.name, digitalocean_ssh_key.generated.*.name), 0)
  description = "Name of SSH key"
}

output "key_fingerprint" {
  value = element(concat(data.digitalocean_ssh_key.referenced.*.fingerprint, digitalocean_ssh_key.imported.*.fingerprint, digitalocean_ssh_key.generated.*.fingerprint), 0)
  description = "The fingerprint of the SSH key"
}

output "public_key" {
  value = element(concat(data.digitalocean_ssh_key.referenced.*.public_key, digitalocean_ssh_key.imported.*.public_key, digitalocean_ssh_key.generated.*.public_key), 0)
  description = "Content of the generated public key"
}

output "private_key" {
  sensitive = true
  value = element(concat(tls_private_key.generated.*.private_key_pem, [""]), 0)
  description = "Content of the generated private key"
}

output "public_key_local_filename" {
  value = element(concat(local_file.public_key.*.filename, [""]), 0)
  description = "Public Key local filename"
}

output "private_key_local_filename" {
  value = element(concat(local_file.private_key.*.filename, [""]), 0)
  description = "Private Key local filename"
}
