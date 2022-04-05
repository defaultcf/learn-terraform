resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = "tf-example-vpc"
  }
}

resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.main.id
  availability_zone = var.availability_zone
  cidr_block        = var.private_1_cidr_block

  tags = {
    Name = "tf-example-private-subnet-1"
  }
}

# --- VPC Endpoint ---

resource "aws_vpc_endpoint" "ssm" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.ap-northeast-1.ssm"
  vpc_endpoint_type = "Interface"

  security_group_ids  = [var.security_group_vpc_endpoint]
  subnet_ids          = [aws_subnet.private_1.id]
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.ap-northeast-1.ssmmessages"
  vpc_endpoint_type = "Interface"

  security_group_ids  = [var.security_group_vpc_endpoint]
  subnet_ids          = [aws_subnet.private_1.id]
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.ap-northeast-1.ec2messages"
  vpc_endpoint_type = "Interface"

  security_group_ids  = [var.security_group_vpc_endpoint]
  subnet_ids          = [aws_subnet.private_1.id]
  private_dns_enabled = true
}
