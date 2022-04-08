data "aws_ami" "latest_amazon_linux" {
  owners      = ["self"]
  most_recent = true

  filter {
    name   = "name"
    values = ["learn-packer-amazon-linux-httpd-*"]
  }
}

resource "aws_instance" "app_server_1" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = var.private_1
  iam_instance_profile   = var.iam_instance_profile
  vpc_security_group_ids = [var.app_server_sg]

  tags = {
    Name = "tf-example-instance_1"
  }
}

resource "aws_instance" "app_server_2" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = var.private_2
  iam_instance_profile   = var.iam_instance_profile
  vpc_security_group_ids = [var.app_server_sg]

  tags = {
    Name = "tf-example-instance_2"
  }
}

resource "aws_lb" "main" {
  name            = "tf-example-alb"
  security_groups = [var.alb_sg]
  subnets         = [var.public_1, var.public_2]

  tags = {
    Name = "tf-example-alb"
  }
}

resource "aws_lb_target_group" "main" {
  name     = "tf-example-lb-tg"
  vpc_id   = var.vpc
  port     = 80
  protocol = "HTTP"

  tags = {
    Name = "tf-example-alb-tg"
  }
}

resource "aws_lb_target_group_attachment" "app_server_1" {
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = aws_instance.app_server_1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "app_server_2" {
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = aws_instance.app_server_2.id
  port             = 80
}


resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }

  tags = {
    Name = "tf-example-alb-listener"
  }
}
