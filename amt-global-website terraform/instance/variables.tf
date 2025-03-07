variable "instance_type" {
  description = "The type of EC2 instance to launch."
  type        = string
  default     = "t3.medium"
}

variable "tag" {
  type        = string
  description = "value"
}

variable "key_pair_name" {
  description = "The name of the existing EC2 key pair"
  type        = string
  default     = "Amalitech-Website"
}

variable "aws_security_group" {
  description = "The ID of the security group"
  type        = list(string)
}

variable "subnet_id" {
  description = "The ID of the subnet"
  type        = string
  default = "value"
}

variable "availability_zone" {
  description = "The availability zone of the EC2 instance"
  type        = string
  default     = "eu-west-1a" 
}

variable "iam_code_deploy_name" {
  description = "The IAM role for CodeDeploy"
  type        = string
}

