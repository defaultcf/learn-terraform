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
    payload = "AQICAHinIzLBEQGPIQZ8CFx1RFXHMhD0cxaeM/sTLRzXEZKFOQEBK7QyihFcMwCYMnQIE33fAAAAZzBlBgkqhkiG9w0BBwagWDBWAgEAMFEGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMUXqWrLfiyxkvpmysAgEQgCTRGjhg0ErgH84hbMPiVwJtFfKh6yd9sMJlPSaTv/4Ulf/++ZE="
  }

  secret {
    name    = "rds_password"
    payload = "AQICAHinIzLBEQGPIQZ8CFx1RFXHMhD0cxaeM/sTLRzXEZKFOQGXzE8QCG/1QgPNCSzUNtWDAAAAczBxBgkqhkiG9w0BBwagZDBiAgEAMF0GCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQM1v6QKU9M+b5Xv82HAgEQgDDELF/N+D2kTkJVi3q8zPgShGbVy7Ny/B8FNyi7DOMn7+47gj27AWnYH2RzdScv5ds="
  }
}
