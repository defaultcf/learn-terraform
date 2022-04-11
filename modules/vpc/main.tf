resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = "tf-example-vpc"
  }
}

resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.main.id
  availability_zone = var.private_1_az
  cidr_block        = var.private_1_cidr_block

  tags = {
    Name = "tf-example-private-subnet-1"
  }
}

resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.main.id
  availability_zone = var.private_2_az
  cidr_block        = var.private_2_cidr_block

  tags = {
    Name = "tf-example-private-subnet-2"
  }
}

resource "aws_subnet" "public_1" {
  vpc_id            = aws_vpc.main.id
  availability_zone = var.public_1_az
  cidr_block        = var.public_1_cidr_block

  tags = {
    Name = "tf-example-public-subnet-1"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id            = aws_vpc.main.id
  availability_zone = var.public_2_az
  cidr_block        = var.public_2_cidr_block

  tags = {
    Name = "tf-example-public-subnet-2"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "tf-example-internet-gateway"
  }
}

resource "aws_route_table" "public_1" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "tf-example-public-1"
  }
}

resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public_1.id
}

resource "aws_route_table" "public_2" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "tf-example-public-2"
  }
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public_2.id
}

resource "aws_eip" "nat_gateway" {
  vpc = true

  tags = {
    Name = "for_nat_gateway"
  }
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.public_1.id
  depends_on    = [aws_internet_gateway.main]

  tags = {
    Name = "tf-example-nat-gateway"
  }
}

resource "aws_route_table" "private_1" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = {
    Name = "tf-example-private-1"
  }
}

resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private_1.id
}

resource "aws_route_table" "private_2" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = {
    Name = "tf-example-private-2"
  }
}

resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private_2.id
}

# --- VPC Endpoint ---

resource "aws_vpc_endpoint" "ssm" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${var.region}.ssm"
  vpc_endpoint_type = "Interface"

  security_group_ids  = [aws_security_group.vpc_endpoint.id]
  subnet_ids          = [aws_subnet.private_1.id]
  private_dns_enabled = true

  tags = {
    Name = "tf-example-vpc-endpoint-ssm"
  }
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${var.region}.ssmmessages"
  vpc_endpoint_type = "Interface"

  security_group_ids  = [aws_security_group.vpc_endpoint.id]
  subnet_ids          = [aws_subnet.private_1.id]
  private_dns_enabled = true

  tags = {
    Name = "tf-example-vpc-endpoint-ssmmessages"
  }
}

resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${var.region}.ec2messages"
  vpc_endpoint_type = "Interface"

  security_group_ids  = [aws_security_group.vpc_endpoint.id]
  subnet_ids          = [aws_subnet.private_1.id]
  private_dns_enabled = true

  tags = {
    Name = "tf-example-vpc-endpoint-ec2messages"
  }
}
