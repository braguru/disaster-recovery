variable "elb_name" {
  description = "Name of the ELB"
  type        = string
  default     = "DR-LB"
}

variable "subnets" {
  description = "Subnets to attach the ELB"
  type        = list(string)
}

variable "security_groups" {
  description = "Security groups to attach the ELB"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "target_group_name" {
  description = "Name of the target group"
  type        = string
  default     = "DR-TG"
}
