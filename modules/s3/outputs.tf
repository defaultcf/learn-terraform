output "codepipeline" {
  value = aws_s3_bucket.codepipeline.id
}

output "codepipeline_arn" {
  value = aws_s3_bucket.codepipeline.arn
}
