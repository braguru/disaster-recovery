provider "aws" {
  alias   = "replica"
  region  = "eu-central-1"
  profile = var.profile
}

resource "aws_s3_bucket" "dr-s3-primary-bucket" {
  bucket        = "dr-s3-primary-bucket"
  force_destroy = true
}

resource "aws_s3_bucket" "dr-s3-bucket-replica" {
  provider      = aws.replica
  bucket        = "dr-s3-bucket-replica"
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "dr-s3-primary-bucket-versioning" {
  bucket = aws_s3_bucket.dr-s3-primary-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "dr-s3-bucket-replica-versioning" {
  bucket = aws_s3_bucket.dr-s3-bucket-replica.id
  provider = aws.replica
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_replication_configuration" "dr-s3-bucket-replica-config" {
  bucket = aws_s3_bucket.dr-s3-primary-bucket.id
  role   = var.replication_role_arn
  count  = 0

  rule {
    id     = "dr-s3-bucket-replica-rule"
    status = "Enabled"

    destination {
      bucket        = aws_s3_bucket.dr-s3-bucket-replica.arn
      storage_class = "STANDARD"
    }
  }
}


