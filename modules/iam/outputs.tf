output "role_ec2_arn" {
  value = aws_iam_role.ec2.arn
}
output "instance_profile" {
  value = aws_iam_instance_profile.systems_manager.name
}
