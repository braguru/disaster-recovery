variable "region" {
  type        = string
  description = "AWS region"
  default     = "eu-west-1"
}

variable "profile" {
  type        = string
  description = "AWS profile"
  default     = "default"
}

variable "sg_name" {
  type        = string
  description = "Projects security group name"
}

variable "vpc_id" {
  type        = string
  description = "value"
}

variable "instance_type" {
  type        = string
  description = "Project-specific instance type"
  default     = "t3.medium"
}

variable "subnet" {
  type        = string
  description = "Project-specific subnet ID"
}

variable "tags" {
  description = "Project-specific tags"
  type        = map(string)
  default = {
    Environment = "dev"
    Terraform   = "true"
    Name        = "icon"
  }
}

variable "vpc_sg_ingress" {
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  description = "value"
}

variable "vpc_sg_egress" {
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  description = "value"
}

variable "ebs_root_volume" {
  type = object({
    volume_size = number
    volume_type = string
  })
  description = "value"
}

### S3
variable "bucket_name" {
  type        = string
  description = "S3 bucket name"
}



### CodeDeploy
variable "app_name" {
  type        = string
  description = "CodeDeploy application name"
}

variable "deployment_groups" {
  type        = list(string)
  description = "CodeDeploy deployment group name"
}


### ECR
variable "repo_name" {
  type        = string
  description = "ECR repository name"
}


### Backend Name
variable "backend_name" {
  type        = string
  description = "Backend name"
}
