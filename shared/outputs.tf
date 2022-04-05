output "instance_1_id" {
  value = module.ec2.instance_1_id
}

output "instance_2_id" {
  value = module.ec2.instance_2_id
}

output "distribution_domain" {
  value = module.cloudfront.distribution_domain
}
