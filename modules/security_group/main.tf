resource "aws_security_group" "vpc_endpoint" {
  name   = "endpoint"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "vpc_endpoint_ingress_https" {
  security_group_id = aws_security_group.vpc_endpoint.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  to_port           = 443
  protocol          = "tcp"
}
