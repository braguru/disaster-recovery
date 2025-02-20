provider "aws" {
  region  = var.region
  profile = var.aws_profile
}

module "vpc" {
  source = "./vpc"

  enable_dns_hostnames = true
  enable_dns_support   = true
}

module "subnet" {
  source = "./subnet"
  vpc_id = module.vpc.vpc_id
}

module "route_table" {
  source    = "./route_table"
  vpc_id    = module.vpc.vpc_id
  subnet_id = module.subnet.subnet_id
}

module "security_group" {
  source = "./security-group"
  vpc_id = module.vpc.vpc_id
}

module "Amalitech-Website-instance" {
  source = "./instance"
  subnet_id          = module.subnet.subnet_id
  aws_security_group = [module.security_group.security_group_id]
  tag                = "Amalitech-Website"
}
