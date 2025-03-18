output "sns_topic_arn" {
  value = aws_sns_topic.dr-topic.arn
}

output "sns_topic" {
  value = aws_sns_topic.dr-topic
}