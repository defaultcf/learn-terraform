module "iam" {
  source = "../../modules/iam"
}

module "security_group" {
  source = "../../modules/security_group"
  vpc    = module.vpc.vpc
}

module "vpc" {
  source          = "../../modules/vpc"
  region          = local.region
  private_1_az    = local.private_1_az
  private_2_az    = local.private_2_az
  public_1_az     = local.public_1_az
  public_2_az     = local.public_2_az
  vpc_endpoint_sg = module.security_group.vpc_endpoint
}

module "ec2" {
  source               = "../../modules/ec2"
  vpc                  = module.vpc.vpc
  private_1            = module.vpc.subnet_private_1
  private_2            = module.vpc.subnet_private_2
  public_1             = module.vpc.subnet_public_1
  public_2             = module.vpc.subnet_public_2
  iam_instance_profile = module.iam.iam_instance_profile
  alb_sg               = module.security_group.alb
  app_server_sg        = module.security_group.app_server
}

module "cloudfront" {
  source       = "../../modules/cloudfront"
  alb_dns_name = module.ec2.alb_dns_name
}
