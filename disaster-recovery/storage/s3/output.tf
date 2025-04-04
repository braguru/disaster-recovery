output "dr-s3-bucket-name" {
  value = aws_s3_bucket.dr-s3-primary-bucket.bucket_domain_name
}

output "dr-s3-bucket-replica-name" {
  value = aws_s3_bucket.dr-s3-bucket-replica.bucket_domain_name
}

output "dr-s3-bucket-arn" {
  value = aws_s3_bucket.dr-s3-primary-bucket.arn
}

output "dr-s3-bucket-replica-arn" {
  value = aws_s3_bucket.dr-s3-bucket-replica.arn
}
