variable "replication_role_arn" {
  type = string
  description = "The ARN of the IAM role for replication"
}

variable "profile" {
  type = string
  description = "The profile for the AWS CLI"
  default = "own-account"
}
