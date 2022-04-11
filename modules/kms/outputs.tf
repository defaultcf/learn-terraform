output "rds_username" {
  value = data.aws_kms_secrets.credentials.plaintext["rds_username"]
}

output "rds_password" {
  value = data.aws_kms_secrets.credentials.plaintext["rds_password"]
}
