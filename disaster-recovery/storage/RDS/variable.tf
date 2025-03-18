variable "instance_class" {
  type = string
  description = "Instance class of the RDS instance"
  default = "db.t3.micro"
}

variable "allocated_storage" {
  type = number
  description = "Allocated storage of the RDS instance"
  default = 20
}

variable "db_name" {
  type = string
  description = "Name of the database"
  default = "drdb"
}

variable "engine" {
  type = string
  description = "Engine of the RDS instance"
  default = "postgres"
}

variable "username" {
  type = string
  description = "Username of the RDS instance"
  default = "guru"
}

variable "password" {
  type = string
  description = "Password of the RDS instance"
  default = "password"
}

variable "max_allocated_storage" {
  type = number
  description = "Max allocated storage of the RDS instance"
  default = 100
}

variable "db_subnet_group_name" {
  type = string
  description = "Name of the DB subnet group"
}

variable "vpc_security_group_id" {
  type = list(string)
  description = "ID of the VPC security group"
}

variable "multi_az" {
  type = bool
  description = "Multi AZ of the RDS instance"
  default = false
}

# variable "availability_zone" {
#   type = string
#   description = "Availability zone of the RDS instance"
# }

variable "storage_type" {
  type = string
  description = "Storage type of the RDS instance"
  default = "gp3"
}

variable "publicly_accessible" {
  type = bool
  description = "Publicly accessible of the RDS instance"
  default = false
}

variable "backup_retention_period" {
  type = number
  description = "Backup retention period of the RDS instance"
  default = 35
}

variable "name" {
  type = string
  description = "Name of the RDS instance"
  default = "dr-rds"
}







