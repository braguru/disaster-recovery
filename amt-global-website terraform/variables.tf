variable "region" {
  description = "The region in which the resources will be created."
  type        = string
  default     = "eu-west-1"
}

variable "enable_dns_support" {
  description = "A boolean flag to enable/disable DNS support in the VPC."
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "aws_profile" {
  description = "The AWS profile to use"
  type        = string
  default     = "marketing-cli"
}

