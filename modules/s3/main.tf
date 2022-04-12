#resource "aws_s3_bucket" "codepipeline" {
#  bucket = var.s3_codepipeline_name
#
#  tags = {
#    Name = "tf-example-s3-codepipeline"
#  }
#}
#
#resource "aws_s3_bucket_acl" "codepipeline" {
#  bucket = aws_s3_bucket.codepipeline.id
#  acl    = "private"
#}
#
#resource "aws_s3_bucket_public_access_block" "codepipeline" {
#  bucket                  = aws_s3_bucket.codepipeline.id
#  block_public_acls       = true
#  block_public_policy     = true
#  ignore_public_acls      = true
#  restrict_public_buckets = true
#}

data "aws_s3_bucket" "codepipeline" {
  bucket = var.s3_codepipeline_name
}
