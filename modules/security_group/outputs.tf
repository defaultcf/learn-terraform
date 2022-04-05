output "vpc_endpoint" {
  value = aws_security_group.vpc_endpoint.id
}

output "alb" {
  value = aws_security_group.alb.id
}

output "app_server" {
  value = aws_security_group.app_server.id
}
