
module "networking" {
  source = "./modules/networking"
}

module "ssh_key" {
  source = "./modules/ssh-key"
}

module "ec2" {
  source        = "./modules/ec2"
  public_subnet = module.networking.public_subnet_id
  private_subnet = module.networking.private_subnet_id
  key_name      = module.ssh_key.key_name
  vpc_security_group_ids = module.networking.security_group_id
}
