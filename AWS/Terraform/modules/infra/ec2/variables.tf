variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t3.medium"
}

variable "subnet" {
  type        = string
  description = "Subnet ID where the EC2 instance will be launched"
}

variable "vpc_sg_id" {
  type        = list(string)
  description = "VPC Security Group ID(s) to attach to the EC2 instance"
}

variable "tags" {
  type        = map(string)
  description = "Tags for the EC2 instance"
}

variable "user_data" {

}

variable "ebs_root_volume" {
  type = object({
    volume_size = number
    volume_type = string
  })
}
