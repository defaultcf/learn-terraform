module "kms" {
  source               = "../../modules/kms"
  rds_username_payload = local.rds_username_payload
  rds_password_payload = local.rds_password_payload
}

module "s3" {
  source               = "../../modules/s3"
  s3_codepipeline_name = local.s3_codepipeline_name
}

module "vpc" {
  source       = "../../modules/vpc"
  region       = local.region
  private_1_az = local.private_1_az
  private_2_az = local.private_2_az
  public_1_az  = local.public_1_az
  public_2_az  = local.public_2_az
}

module "ec2" {
  source              = "../../modules/ec2"
  region              = local.region
  vpc                 = module.vpc.vpc
  private_1           = module.vpc.subnet_private_1
  private_2           = module.vpc.subnet_private_2
  public_1            = module.vpc.subnet_public_1
  public_2            = module.vpc.subnet_public_2
  s3_codepipeline     = module.s3.codepipeline
  s3_codepipeline_arn = module.s3.codepipeline_arn
}

module "rds" {
  source        = "../../modules/rds"
  vpc           = module.vpc.vpc
  private_1     = module.vpc.subnet_private_1
  private_2     = module.vpc.subnet_private_2
  sg_app_server = module.ec2.sg_app_server
  rds_username  = module.kms.rds_username
  rds_password  = module.kms.rds_password
}

module "cloudfront" {
  source       = "../../modules/cloudfront"
  alb_dns_name = module.ec2.alb_dns_name
}

module "codesuite" {
  source               = "../../modules/codesuite"
  iam_role_ec2_arn     = module.ec2.iam_role_ec2_arn
  autoscaling_group    = module.ec2.autoscaling_group
  lb_target_group_name = module.ec2.lb_target_group_name
  s3_codepipeline      = module.s3.codepipeline
  s3_codepipeline_arn  = module.s3.codepipeline_arn
  key_id               = module.kms.key_id
}
