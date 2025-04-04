variable "map_public_ip_on_launch" {
  type        = bool
  description = "Map public ip on launch"
  default     = true
}

variable "map_private_ip_on_launch" {
  type        = bool
  description = "Map private ip on launch"
  default     = false
}

variable "availability_zone_az1" {
  type        = string
  description = "Availability zone of the subnet in AZ1"
  default     = "eu-west-1a"
}

variable "availability_zone_az2" {
  type        = string
  description = "Availability zone of the subnet in AZ2"
  default     = "eu-west-1b"
}

variable "public_subnet_name_az1" {
  type        = string
  description = "Name of the public subnet in AZ1"
  default     = "DR-Public-Subnet-az1"
}

variable "public_subnet_name_az2" {
  type        = string
  description = "Name of the public subnet in AZ2"
  default     = "DR-Public-Subnet-az2"
}

variable "private_subnet_name_az1" {
  type        = string
  description = "Name of the private subnet in AZ1"
  default     = "DR-Private-Subnet-1-az1"
}

variable "private_subnet_name_az2" {
  type        = string
  description = "Name of the private subnet in AZ2"
  default     = "DR-Private-Subnet-2-az2"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}

variable "cidr_block_public_az1" {
  type        = string
  description = "CIDR block of the subnet"
  default     = "10.0.6.0/24"
}

variable "cidr_block_public_az2" {
  type        = string
  description = "CIDR block of the subnet"
  default     = "10.0.7.0/24"
}


variable "cidr_block_private_az1" {
  type        = string
  description = "CIDR block of the private subnet in AZ1"
  default     = "10.0.8.0/24"
}

variable "cidr_block_private_az2" {
  type        = string
  description = "CIDR block of the private subnet in AZ2"
  default     = "10.0.9.0/24"
}

variable "cidr_block_private_RDS_az1" {
  type        = string
  description = "CIDR block of the private subnet in AZ1"
  default     = "10.0.10.0/24"
}

variable "cidr_block_private_RDS_az2" {
  type        = string
  description = "CIDR block of the private subnet in AZ2"
  default     = "10.0.11.0/24"
}

variable "private_subnet_name_RDS_az1" {
  type        = string
  description = "Name of the private subnet in AZ1"
  default     = "DR-Private-Subnet-RDS-az1"
}

variable "private_subnet_name_RDS_az2" {
  type        = string
  description = "Name of the private subnet in AZ2"
  default     = "DR-Private-Subnet-RDS-az2"
}

variable "DR-Internet-Gateway" {
  type = string
  description = "Name of the internet gateway"
  default = "DR-Internet-Gateway"
}

variable "destination_cidr_block" {
  type = string
  description = "Destination CIDR block"
  default = "0.0.0.0/0"
}

variable "DR-Public-Route-Table" {
  type = string
  description = "Name of the public route table"
  default = "DR-Public-Route-Table"
}

variable "DR-Private-Route-Table" {
  type = string
  description = "Name of the private route table"
  default = "DR-Private-Route-Table"
}

variable "DR-NAT-Gateway" {
  type = string
  description = "Name of the NAT gateway"
  default = "DR-NAT-Gateway"
}

variable "DR-EIP" {
  type = string
  description = "ID of the EIP"
  default = "DR-EIP"
}

variable "db_subnet_group_name" {
  type = string
  description = "Name of the DB subnet group"
  default = "dr-db-subnet-group"
}


