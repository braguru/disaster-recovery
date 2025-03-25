variable "app_runner_role_arn" {
  type = string
  description = "The ARN of the AppRunner role"
}   

variable "ecr_repository_url" {
  type = string
  description = "The URL of the ECR repository"
}
