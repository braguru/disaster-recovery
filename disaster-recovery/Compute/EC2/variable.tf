variable "instance_type" {
  type        = string
  description = "Instance type"
  default     = "t3.micro"
}

# variable "subnet_id" {
#   type        = string
#   description = "Subnet ID"
# }

variable "key_pair_name" {
  type        = string
  description = "Key pair name"
  default     = "DR"
}

# variable "availability_zone" {
#   type        = string
#   description = "Availability zone"
# }

variable "aws_security_group" {
  type        = string
  description = "Security group"
}

variable "tag" {
  type        = string
  description = "Tag"
  default     = "DR-Instance"
}

variable "Launch-Template-Name" {
  type        = string
  description = "Launch Template Name"
  default     = "DR-Launch-Template"
}

variable "Auto-Scaling-Group-Name" {
  type        = string
  description = "Auto Scaling Group Name"
  default     = "DR-Auto-Scaling-Group"
}

variable "desired_capacity" {
  type        = number
  description = "Desired capacity"
  default     = 1
}

variable "max_size" {
  type        = number
  description = "Max size"
  default     = 2
}

variable "min_size" {
  type        = number
  description = "Min size"
  default     = 1
}

variable "target_group_arns" {
  type        = list(string)
  description = "Target group ARNs"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs"
}

variable "target_value" {
  type        = number
  description = "Target value"
  default     = 70.0
}

