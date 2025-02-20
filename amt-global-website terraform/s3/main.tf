resource "aws_s3_bucket" "extrf-s3-backend" {
  bucket = var.bucket_name

  tags = {
    Name        = var.tag
    Environment = "Dev"
  }
}
