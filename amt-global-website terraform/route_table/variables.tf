variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

variable "route_table_name" {
  description = "The name of the route table"
  type        = string
  default     = "Amalitech-Website-Route-Table"
}

variable "destination_cidr_block" {
  description = "The CIDR block of the route"
  type        = string
  default     = "0.0.0.0/0"
}

variable "subnet_id" {
  description = "The ID of the subnet"
  type        = string
}

variable "cidr_block" {
  description = "The CIDR block of the route"
  type        = string
  default     = "10.0.0.0/16"
}


variable "egress_only_gateway_id" {
  description = "Egress-only gateway ID (leave empty for none)"
  type        = string
  default     = ""
}
