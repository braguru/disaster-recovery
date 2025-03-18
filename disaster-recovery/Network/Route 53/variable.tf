variable "route53_zone_id" {
  type    = string
  default = "Z033328828GIXBNKRMH6"
}

variable "alb_name" {
  type    = string
}

variable "alb_dns_name" {
  type    = string
}

variable "alb_zone_id" {
  type    = string
}

variable "cloudwatch_alarm_name" {
  type    = string
}

variable "insufficient_data_health_status" {
  type    = string
  default = "Healthy"
}
