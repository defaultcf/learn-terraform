output "iam_role_ec2_arn" {
  value = aws_iam_role.ec2.arn
}

output "alb_dns_name" {
  value = aws_lb.main.dns_name
}

output "lb_target_group_name" {
  value = aws_lb_target_group.main.name
}

output "autoscaling_group" {
  value = aws_autoscaling_group.app_server.id
}
