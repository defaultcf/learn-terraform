#resource "aws_kms_key" "default" {
#  deletion_window_in_days = 7
#
#  tags = {
#    Name = "tf-example-kms-key"
#  }
#}
#
#resource "aws_kms_alias" "default" {
#  name          = "alias/tf-example-key"
#  target_key_id = aws_kms_key.default.id
#}

data "aws_kms_key" "default" {
  key_id = "alias/tf-example-key"
}

data "aws_kms_secrets" "credentials" {
  secret {
    name    = "rds_username"
    payload = var.rds_username_payload
  }

  secret {
    name    = "rds_password"
    payload = var.rds_password_payload
  }
}
