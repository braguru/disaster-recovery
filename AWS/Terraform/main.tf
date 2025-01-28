module "security_group" {
  source     = "./modules/network/sg"
  vpc_id     = var.vpc_id
  sg_name    = var.sg_name
  sg_ingress = var.vpc_sg_ingress
}

module "EC2_instance" {
  source          = "./modules/infra/ec2"
  instance_type   = var.instance_type
  subnet          = var.subnet
  vpc_sg_id       = [module.security_group.sg_id]
  ebs_root_volume = var.ebs_root_volume
  user_data       = filebase64("${path.module}/install.sh")
  ami_owners =  ["099720109477"]
  ami_name_filter =  ["ubuntu/images/hvm-ssd/ubuntu-*-amd64-server-*"]
  tags = {
    Environment = "Development"
    Terraform   = "true"
    Name        = var.instance_name
  }
}

module "S3_bucket" {
  source      = "./modules/infra/s3"
  bucket_name = var.bucket_name
  tags = {
    Environment = "Development"
    Terraform   = "true"
    Name        = var.bucket_name
  }
}

module "codedeploy" {
  source            = "./modules/infra/codedeploy"
  app_name          = var.app_name
  deployment_groups = var.deployment_groups
  instance_name     = module.EC2_instance.instance_name
  alarm_name        = "icon-alarm"
}

module "ecr" {
  source    = "./modules/infra/ecr"
  repo_name = var.repo_name
}
