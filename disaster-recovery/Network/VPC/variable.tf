variable "enable_dns_hostnames" {
  type    = bool
  default = true
}

variable "enable_dns_support" {
  type    = bool
  default = true
}

variable "vpc_name" {
  type    = string
  default = "Disaster-Recovery-VPC"
}

variable "cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}
