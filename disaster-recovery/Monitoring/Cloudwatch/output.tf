output "cloudwatch_log_group_arn" {
  value = aws_cloudwatch_log_group.dr-cloudwatch-log-group.arn
}

output "cloudwatch_log_group_name" {
  value = aws_cloudwatch_log_group.dr-cloudwatch-log-group.name
}

output "cloudwatch_log_group_retention_in_days" {
  value = aws_cloudwatch_log_group.dr-cloudwatch-log-group.retention_in_days
}

output "cloudwatch_log_group_tags" {
  value = aws_cloudwatch_log_group.dr-cloudwatch-log-group.tags
}

