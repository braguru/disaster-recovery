data "aws_s3_bucket" "existing_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket" "this" {
  count = length(try(data.aws_s3_bucket.existing_bucket.id, [])) == 0 ? 1 : 0

  bucket        = var.bucket_name
  force_destroy = false
  tags          = var.tags
}
