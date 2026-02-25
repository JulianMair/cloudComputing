output "alb_dns" {
  value       = aws_lb.alb.dns_name
  description = "Public DNS of the ALB"
}

output "cloudfront_domain" {
  description = "CloudFront Domain for PartyQueue"
  value       = aws_cloudfront_distribution.partyqueue.domain_name
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.main.name
}

output "ecs_service_name" {
  value = aws_ecs_service.app.name
}
