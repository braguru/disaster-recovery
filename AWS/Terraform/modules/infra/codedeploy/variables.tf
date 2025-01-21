variable "app_name" {
  type        = string
  description = "value"
}

variable "sns_topic" {
  type        = string
  description = "value"
  default     = "deployment-topic"
}

variable "instance_name" {
  type        = string
  description = "value"
}

variable "alarm_name" {
  type        = string
  description = "value"
}

variable "deployment_groups" {
  type        = list(string)
  description = "value"
}

variable "deployment_group_sns_topic" {
  type        = string
  description = "value"
  default     = "deployment-topic"
}
