resource "aws_sns_topic" "dr-topic"{
    name = "disaster-recovery-topic"
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.dr-topic.arn
  protocol = "email"
  endpoint = "sabastainofori@gmail.com"
}