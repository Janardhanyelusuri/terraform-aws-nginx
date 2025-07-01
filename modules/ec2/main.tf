
resource "aws_instance" "public_vm" {
  ami                    = "ami-020cba7c55df1f615" # Replace with region-specific AMI
  instance_type          = "t2.micro"
  subnet_id              = var.public_subnet
  key_name               = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install nginx -y
              sudo systemctl enable nginx
              sudo systemctl start nginx
              EOF
 tags = {
    Name = "public_vm"
  }
}

resource "aws_instance" "private_vm" {
  ami                    = "ami-020cba7c55df1f615" # Replace with region-specific AMI
  instance_type          = "t2.micro"
  subnet_id              = var.private_subnet
  key_name               = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install nginx -y
              sudo systemctl enable nginx
              sudo systemctl start nginx
              EOF
 tags = {
    Name = "private_vm"
  }
}

output "public_instance_ip" {
  value = aws_instance.public_vm.public_ip
}


variable "public_subnet" {}
variable "private_subnet" {}
variable "key_name" {}
variable "vpc_security_group_ids" {}
