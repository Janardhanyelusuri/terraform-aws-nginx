resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "auto-key"
  public_key = tls_private_key.example.public_key_openssh
}

resource "local_file" "private_key_pem" {
  content              = tls_private_key.example.private_key_pem
  filename             = "${path.module}/terraform-key.pem"
  file_permission      = "0400"
}

output "key_name" {
  value = aws_key_pair.generated_key.key_name
}

output "private_key_path" {
  value = local_file.private_key_pem.filename
}
