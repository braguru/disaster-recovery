variable "vpc_id" {
  type    = string
}

variable "iam_role_arn" {
  type    = string
}

variable "traffic_type" {
  type    = string
  default = "ALL"
}

variable "asg_name" {
  type    = string
}

variable "alb_name" {
  type    = string
}

variable "sns_topic_arn" {
  type = string
}

