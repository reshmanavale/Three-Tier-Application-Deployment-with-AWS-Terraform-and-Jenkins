module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  az                  = var.az
}

module "security" {
  source  = "./modules/security"
  vpc_id  = module.vpc.vpc_id
  my_ip   = var.my_ip
}

module "ec2" {
  source             = "./modules/ec2"
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  public_subnet_id   = module.vpc.public_subnet_id
  private_subnet_id  = module.vpc.private_subnet_id
  web_sg_id          = module.security.web_sg_id
  db_sg_id           = module.security.db_sg_id
  key_name           = var.key_name
}
