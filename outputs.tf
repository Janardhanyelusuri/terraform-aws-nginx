output "public_instance_ip" {
  value = module.ec2.public_instance_ip
}

output "key_name" {
  value = module.ssh_key.key_name
}

output "private_key_path" {
  value = module.ssh_key.private_key_path
}
