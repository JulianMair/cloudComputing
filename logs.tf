resource "aws_cloudwatch_log_group" "partyqueue" {
  name              = "/ecs/partyqueue"
  retention_in_days = 7
}
