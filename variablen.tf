variable "aws_region" {
  description = "AWS region for all resources"
  type        = string
  default     = "eu-central-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_a_cidr" {
  description = "CIDR block for public subnet A"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_b_cidr" {
  description = "CIDR block for public subnet B"
  type        = string
  default     = "10.0.2.0/24"
}

variable "public_subnet_a_az" {
  description = "Availability zone for public subnet A"
  type        = string
  default     = "eu-central-1a"
}

variable "public_subnet_b_az" {
  description = "Availability zone for public subnet B"
  type        = string
  default     = "eu-central-1b"
}

variable "public_ingress_cidr_blocks" {
  description = "Allowed CIDR blocks for public ingress"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "alb_security_group_name" {
  description = "Security group name for the ALB"
  type        = string
  default     = "partyqueue-alb-sg"
}

variable "ecs_security_group_name" {
  description = "Security group name for ECS tasks"
  type        = string
  default     = "partyqueue-ecs-sg"
}

variable "alb_name" {
  description = "Application Load Balancer name"
  type        = string
  default     = "partyqueue-alb"
}

variable "target_group_name" {
  description = "ALB target group name"
  type        = string
  default     = "partyqueue-tg"
}

variable "alb_listener_port" {
  description = "ALB listener port"
  type        = number
  default     = 80
}

variable "app_port" {
  description = "Application container and target group port"
  type        = number
  default     = 3000
}

variable "ecs_cluster_name" {
  description = "ECS cluster name"
  type        = string
  default     = "partyqueue-cluster"
}

variable "ecs_task_family" {
  description = "ECS task definition family"
  type        = string
  default     = "partyqueue"
}

variable "container_name" {
  description = "Container name used in ECS task/service"
  type        = string
  default     = "partyqueue"
}

variable "container_image" {
  description = "Container image for the application"
  type        = string
  default     = "julianmair/partyqueue:latest"
}

variable "ecs_task_cpu" {
  description = "CPU units for the ECS task definition"
  type        = string
  default     = "256"
}

variable "ecs_task_memory" {
  description = "Memory (MiB) for the ECS task definition"
  type        = string
  default     = "512"
}

variable "ecs_service_name" {
  description = "ECS service name"
  type        = string
  default     = "partyqueue-service"
}

variable "ecs_desired_count" {
  description = "Desired number of ECS tasks"
  type        = number
  default     = 1
}

variable "ecs_autoscaling_min_capacity" {
  description = "Minimum ECS service autoscaling capacity"
  type        = number
  default     = 1
}

variable "ecs_autoscaling_max_capacity" {
  description = "Maximum ECS service autoscaling capacity"
  type        = number
  default     = 2
}

variable "ecs_cpu_target_value" {
  description = "CPU utilization target for ECS autoscaling"
  type        = number
  default     = 70
}

variable "ecs_scale_in_cooldown" {
  description = "Scale-in cooldown for ECS autoscaling policy"
  type        = number
  default     = 60
}

variable "ecs_scale_out_cooldown" {
  description = "Scale-out cooldown for ECS autoscaling policy"
  type        = number
  default     = 60
}

variable "ecs_execution_role_name" {
  description = "IAM role name for ECS task execution"
  type        = string
  default     = "ecs_execution_role"
}

variable "cloudwatch_log_group_name" {
  description = "CloudWatch log group name for ECS logs"
  type        = string
  default     = "/ecs/partyqueue"
}

variable "cloudwatch_log_retention_days" {
  description = "CloudWatch log retention in days"
  type        = number
  default     = 7
}

variable "cloudfront_origin_id" {
  description = "Origin ID used by CloudFront"
  type        = string
  default     = "ALB-partyqueue"
}

variable "cloudfront_default_ttl" {
  description = "Default TTL for CloudFront cache behavior"
  type        = number
  default     = 300
}

variable "cloudfront_max_ttl" {
  description = "Maximum TTL for CloudFront cache behavior"
  type        = number
  default     = 600
}

variable "cloudfront_tag_name" {
  description = "Name tag for the CloudFront distribution"
  type        = string
  default     = "partyqueue-cloudfront"
}
