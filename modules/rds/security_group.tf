resource "aws_security_group" "rds" {
  name   = "rds"
  vpc_id = var.vpc

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.sg_app_server]
  }

  tags = {
    Name = "tf-example-rds-sg"
  }
}
