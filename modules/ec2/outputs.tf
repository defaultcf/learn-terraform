output "instance_1_id" {
  value = aws_instance.app_server_1.id
}

output "instance_2_id" {
  value = aws_instance.app_server_2.id
}


output "alb_dns_name" {
  value = aws_lb.main.dns_name
}
