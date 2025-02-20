variable "ebs_volume_size" {
  description = "Size of the EBS volume to attach (in GB)"
  type        = number
  default     = 24
}

variable "volume_name" {
  description = "Name of the EBS volume"
  type        = string
  default = "Amalitech-Website-volume"
}

variable "device_name" {
  description = "Device name to attach the volume"
  type        = string
  default     = "/dev/xvda"
}

variable "aws_instance_id" {
  description = "The ID of the EC2 instance"
  type        = string
}

variable "availability_zone" {
  description = "The availability zone of the EBS volume"
  type        = string
  default     = "eu-west-1a"
  
}


variable "ebs_type" {
  description = "value of the ebs type"
  type = string
  default = "gp3"
}