# resource "aws_s3_bucket" "extrf-s3-backend" {
#   bucket = var.bucket_name

#   tags = {
#     Name        = var.tag
#     Environment = "Dev"
#   }
# }


resource "aws_s3_bucket" "amt-artifacts" {
  bucket = "amt-artifacts"
  force_destroy = true

  tags = {
    Name        = "amt-artifacts"
    Environment = "Dev"
  }
}
