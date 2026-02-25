data "aws_ec2_managed_prefix_list" "cloudfront_origin_facing" {
  name = "com.amazonaws.global.cloudfront.origin-facing"
}

# ALB Security Group
resource "aws_security_group" "alb" {
  name        = var.alb_security_group_name
  description = "Allow HTTP only from CloudFront"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port       = var.alb_listener_port
    to_port         = var.alb_listener_port
    protocol        = "tcp"
    prefix_list_ids = [data.aws_ec2_managed_prefix_list.cloudfront_origin_facing.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.public_ingress_cidr_blocks
  }
}

# ECS Security Group
resource "aws_security_group" "ecs" {
  name        = var.ecs_security_group_name
  description = "Allow ALB to access ECS containers"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port       = var.app_port
    to_port         = var.app_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.public_ingress_cidr_blocks
  }
}
