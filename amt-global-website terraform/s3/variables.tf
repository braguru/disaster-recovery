variable "bucket_name" {
    description = "The name of the S3 bucket"
    type        = string
    default     = "amaliweb-trf-s3-backend"
}

variable "tag" {
  description = "value of the tag"
  type = string
  default     = "amliweb-s3/tf-backend"
}