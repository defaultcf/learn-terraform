locals {
  origin_id = "alb_web"
}

#data "aws_cloudfront_cache_policy" "caching_optimized" {
#  name = "Managed-CachingOptimized"
#}
#
#data "aws_cloudfront_origin_request_policy" "all_viewer" {
#  name = "Managed-AllViewer"
#}

resource "aws_cloudfront_distribution" "main" {
  enabled = true

  origin {
    origin_id   = local.origin_id
    domain_name = var.alb_dns_name

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  default_cache_behavior {
    target_origin_id       = local.origin_id
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods         = ["GET", "HEAD"]
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400

    #cache_policy_id          = data.aws_cloudfront_cache_policy.caching_optimized.id
    #origin_request_policy_id = data.aws_cloudfront_origin_request_policy.all_viewer.id

    forwarded_values {
      headers      = ["Accept", "Authorization", "Host", "Referer", "CloudFront-Forwarded-Proto"]
      query_string = true

      cookies {
        forward = "all"
      }
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Name = "tf-example-cloudfront"
  }
}
