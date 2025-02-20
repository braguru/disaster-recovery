variable "ssh_access" {
  description = "A list of CIDR blocks which are allowed to connect to the EC2 instances over SSH"
  type        = string
  default     = "0.0.0.0/0" # Allow SSH access from anywhere  
}

variable "tag" {
  type        = map(string)
  description = "A map of tags for the security group"
  default = {
    Name = "Amalitech-Website-Security-Group"
  }
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "sg_name" {
  type = string
  default = "Amalitech-Website-Security-Group"
}

variable "cidr_ipv4" {
  type = string
  default = "0.0.0.0/0" 
}