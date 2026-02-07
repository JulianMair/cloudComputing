#########################
# ALB
#########################
resource "aws_lb" "alb" {
  name               = "partyqueue-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [aws_subnet.public_a.id, aws_subnet.public_b.id]
}

#########################
# Target Group
#########################
resource "aws_lb_target_group" "tg" {
  name        = "partyqueue-tg"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"
}

#########################
# ACM Certificate für HTTPS
#########################
resource "aws_acm_certificate" "partyqueue" {
  domain_name       = "partyqueueaws.fluppit.de"
  validation_method = "DNS"
}

#########################
# HTTP Listener (Port 80)
#########################
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      protocol = "HTTPS"
      port     = "443"
      status_code = "HTTP_301"
    }
  }
}

#########################
# HTTPS Listener (Port 443)
#########################
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.partyqueue.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}
