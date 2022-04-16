data "aws_ami" "latest_amazon_linux" {
  owners      = ["self"]
  most_recent = true

  filter {
    name   = "name"
    values = ["learn-packer-amazon-linux-httpd-*"]
  }
}

resource "aws_launch_configuration" "app_server" {
  name_prefix                      = "tf-example-app-server"
  image_id                         = data.aws_ami.latest_amazon_linux.id
  instance_type                    = var.instance_type
  iam_instance_profile             = aws_iam_instance_profile.systems_manager.name
  security_groups                  = [aws_security_group.app_server.id]
  vpc_classic_link_security_groups = []

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "app_server" {
  name                 = "tf-example-app-server"
  max_size             = 1
  min_size             = 1
  force_delete         = true
  launch_configuration = aws_launch_configuration.app_server.name
  vpc_zone_identifier  = [var.private_1, var.private_2]
  target_group_arns    = [aws_lb_target_group.main.arn]

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 30
    }
    triggers = []
  }

  tag {
    key                 = "Name"
    value               = "tf-example-app-server"
    propagate_at_launch = true
  }
}

# --- ALB ---

resource "aws_lb" "main" {
  name            = "tf-example-alb"
  security_groups = [aws_security_group.alb.id]
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

resource "aws_autoscaling_attachment" "app_server" {
  autoscaling_group_name = aws_autoscaling_group.app_server.id
  lb_target_group_arn    = aws_lb_target_group.main.arn
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
