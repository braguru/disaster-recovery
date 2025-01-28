# General configurations
variable "profile" {
  type        = string
  description = "AWS profile"
}

# EC2 instance configurations
variable "instance_type" {
  type        = string
  description = "Project-specific instance type"
  default     = "t3.medium"
}

variable "instance_name" {
  type        = string
  description = "Project-specific instance name"
  
}

variable "ebs_root_volume" {
  type = object({
    volume_size = number
    volume_type = string
  })
  description = "Project-specific EBS root volume configurations"
}


# Networking configurations
variable "sg_name" {
  type        = string
  description = "Projects security group name"
}

variable "vpc_id" {
  type        = string
  description = "value"
}
variable "subnet" {
  type        = string
  description = "Project-specific subnet ID"
}

variable "tags" {
  description = "Project-specific tags"
  type        = map(string)
  default = {
    Environment = "Development"
    Terraform   = "true"
    Project     = ""
  
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
