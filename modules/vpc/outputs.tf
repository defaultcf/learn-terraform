output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_private_1" {
  value = aws_subnet.private_1.id
}
