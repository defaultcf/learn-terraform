output "vpc" {
  value = aws_vpc.main.id
}

output "subnet_private_1" {
  value = aws_subnet.private_1.id
}

output "subnet_private_2" {
  value = aws_subnet.private_2.id
}

output "subnet_public_1" {
  value = aws_subnet.public_1.id
}

output "subnet_public_2" {
  value = aws_subnet.public_2.id
}
