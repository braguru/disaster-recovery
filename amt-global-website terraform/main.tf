provider "aws" {
  region  = var.region
  profile = var.aws_profile
}

# module "vpc" {
#   source = "./vpc"

#   enable_dns_hostnames = true
#   enable_dns_support   = true
# }

# module "subnet" {
#   source = "./subnet"
#   vpc_id = module.vpc.vpc_id
# }

# module "route_table" {
#   source    = "./route_table"
#   vpc_id    = module.vpc.vpc_id
#   subnet_id = module.subnet.subnet_id
# }

# module "security_group" {
#   source = "./security-group"
#   vpc_id = module.vpc.vpc_id
# }

# module "Amalitech-Website-instance" {
#   source               = "./instance"
#   subnet_id            = module.subnet.subnet_id
#   aws_security_group   = [module.security_group.security_group_id]
#   tag                  = "Amalitech-Website"
#   iam_code_deploy_name = module.iam.ec2_profile_name
# }

# module "s3" {
#   source = "./s3"
# }

module "iam" {
  source = "./iam"
}

# module "codeDeploy" {
#   source           = "./codeDeploy"
#   instance_name    = module.Amalitech-Website-instance.instance_name
#   service_role_arn = module.iam.code_deploy_role_arn
# }

module "ecr" {
  source = "./ecr"
}

module "app_runner" {
  source = "./appRunner"
  ecr_repository_url = module.ecr.ecr_repository_url
  app_runner_role_arn = module.iam.app_runner_role_arn
}
