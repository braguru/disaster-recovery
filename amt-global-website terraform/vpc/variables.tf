variable "vpc_name" {
  description = "value of the vpc name"
  type        = string
  default     = "Default VPC"
}

variable "cidr_block" {
  description = "value of the cidr block"
  type        = string
  # default     = "172.31.0.0/16"
  default = "10.0.0.0/16"
}

variable "enable_dns_support" {
  type    = bool
  default = true
}

variable "enable_dns_hostnames" {
  type    = bool
  default = true
}

variable "vpc_id" {
  type = string
  default = "vpc-0e2118caf952087e8"
}