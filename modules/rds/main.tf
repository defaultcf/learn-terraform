locals {
  subnet_group_name    = "tf-example-subnet-group"
  parameter_group_name = "tf-example-parameter-group"
}

resource "aws_db_subnet_group" "default" {
  name       = local.subnet_group_name
  subnet_ids = [var.private_1, var.private_2]

  tags = {
    Name = "tf-example-db-subnet-group"
  }
}

resource "aws_db_parameter_group" "default" {
  name   = local.parameter_group_name
  family = "mariadb10.6"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }

  tags = {
    Name = "tf-example-parameter-group"
  }
}

resource "aws_db_instance" "default" {
  db_name                = "tf_example_db"
  allocated_storage      = 10
  engine                 = "mariadb"
  engine_version         = "10.6.7"
  instance_class         = "db.t3.micro"
  db_subnet_group_name   = aws_db_subnet_group.default.id
  parameter_group_name   = local.parameter_group_name
  vpc_security_group_ids = [aws_security_group.rds.id]
  skip_final_snapshot    = true

  username = var.rds_username
  password = var.rds_password

  tags = {
    Name = "tf-example-db-instance"
  }
}
