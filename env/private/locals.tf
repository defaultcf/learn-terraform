locals {
  region               = "us-east-1"
  private_1_az         = "us-east-1a"
  private_2_az         = "us-east-1c"
  public_1_az          = "us-east-1a"
  public_2_az          = "us-east-1c"
  s3_codepipeline_name = "tf-example-codepipeline-private"
  rds_username_payload = "AQICAHhlyj2cFuEBJs3VEA+aovdmtZOC2DNbWjHiT7Z8xwW4qgE2AfmNXP2UVlEfOokR+8+bAAAAZjBkBgkqhkiG9w0BBwagVzBVAgEAMFAGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMkOQaKVmiFIehYEYUAgEQgCMw37lhuOQ+KAKKVt6OJ82OS9isyg39I5Qwar9Y0sWcGtab0Q=="
  rds_password_payload = "AQICAHhlyj2cFuEBJs3VEA+aovdmtZOC2DNbWjHiT7Z8xwW4qgEHsmatJeociE3nzMUvnhl9AAAAcjBwBgkqhkiG9w0BBwagYzBhAgEAMFwGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMcqsAl8BDPjpytxaaAgEQgC9zIYrlVIefEuATRrAOTw/QhZnFlmt2+qiTuTMIl680sHim5f7VQ02Lvpe5SngHUg=="
}
