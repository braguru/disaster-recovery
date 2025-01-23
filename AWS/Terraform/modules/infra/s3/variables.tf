variable "bucket_name" {
  type        = string
  description = "value"
}

variable "tags" {
  description = "value"
  type        = map(string)
  default = {
    Environment = "Development"
    Terraform   = "true"
  }
}
