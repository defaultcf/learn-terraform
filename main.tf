module "iam" {
  source = "./modules/iam"
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}

module "vpc" {
  source                      = "./modules/vpc"
  security_group_vpc_endpoint = module.security_group.vpc_endpoint
}

module "instance" {
  source               = "./modules/ec2"
  subnet_id            = module.vpc.subnet_private_1
  iam_instance_profile = module.iam.iam_instance_profile
}
