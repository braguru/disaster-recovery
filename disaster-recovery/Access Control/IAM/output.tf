output "dr-cloudwatch-role-arn" {
  value = aws_iam_role.dr-cloudwatch-role.arn
}

output "dr-cloudwatch-policy-arn" {
  value = aws_iam_policy.dr-cloudwatch-policy.arn
}

output "dr-cloudwatch-role-name" {
  value = aws_iam_role.dr-cloudwatch-role.name
}

output "dr-backup-role-arn" {
  value = aws_iam_role.dr-backup-role.arn
}

output "dr-backup-policy-arn" {
  value = aws_iam_policy.dr-backup-policy.arn
} 

output "dr-backup-role-name" {
  value = aws_iam_role.dr-backup-role.name
}

output "dr-s3-replication-role-arn" {
  value = aws_iam_role.dr-s3-replication-role.arn
}

output "dr-s3-replication-policy-arn" {
  value = aws_iam_policy.dr-s3-replication-policy.arn
}

output "dr-s3-replication-role-name" {
  value = aws_iam_role.dr-s3-replication-role.name
}

output "aws_sns_topic_policy" {
  value = aws_iam_policy.dr-sns-policy
}
