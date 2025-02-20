output "name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.extrf-s3-backend.bucket
}