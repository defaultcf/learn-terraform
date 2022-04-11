resource "aws_security_group" "vpc_endpoint" {
  name   = "endpoint"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 0
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tf-example-vpc-endpoint-sg"
  }
}
