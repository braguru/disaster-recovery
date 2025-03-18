resource "aws_vpc" "main" {
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  cidr_block           = var.cidr_block
  
  tags = {
    Name = var.vpc_name
  }

}
