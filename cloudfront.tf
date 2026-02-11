# CloudFront Distribution
resource "aws_cloudfront_distribution" "partyqueue" {
  enabled             = true

  origin {
    domain_name = aws_lb.alb.dns_name
    origin_id   = "ALB-partyqueue"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  default_cache_behavior {
    target_origin_id       = "ALB-partyqueue"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]

    forwarded_values {
      query_string = false
      cookies {
        forward = "all"
      }
    }

    min_ttl     = 0
    default_ttl = 300
    max_ttl     = 600
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
    Name = "partyqueue-cloudfront"
  }
}

