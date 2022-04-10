locals {
  timestamp = replace(timestamp(), "/T.*Z/", "")
}

resource "aws_s3_bucket" "codepipeline" {
  bucket = "tf-example-codepipeline"
}

resource "aws_s3_bucket_acl" "codepipeline" {
  bucket = aws_s3_bucket.codepipeline.id
  acl    = "private"
}
