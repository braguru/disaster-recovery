provider "aws" {
  region  = var.region
  profile = var.profile
}

# provider "aws" {
#   alias  = "replica"
#   region = "eu-central-1"
# }

module "vpc" {
  source = "./Network/VPC"
}

module "subnet" {
  source = "./Network/Subnet"
  vpc_id = module.vpc.vpc_id
}

module "security_group" {
  source = "./Network/Security Group"
  vpc_id = module.vpc.vpc_id
}

module "elb" {
  source          = "./Network/ELB"
  vpc_id          = module.vpc.vpc_id
  subnets         = [module.subnet.private_subnet_id_az1, module.subnet.private_subnet_id_az2]
  security_groups = [module.security_group.sg_id]
}

module "autoscaling" {
  source             = "./Compute/EC2"
  aws_security_group = module.security_group.sg_id
  target_group_arns  = [module.elb.target_group_arn]
  subnet_ids         = [module.subnet.private_subnet_id_az1, module.subnet.private_subnet_id_az2]
}

module "rds" {
  source                = "./storage/RDS"
  vpc_security_group_id = [module.security_group.rds_sg_id]
  db_subnet_group_name  = module.subnet.db_subnet_group_name
}

module "iam" {
  source                   = "./Access Control/IAM"
  dr-s3-bucket-arn         = module.s3.dr-s3-bucket-arn
  dr-s3-bucket-replica-arn = module.s3.dr-s3-bucket-replica-arn
  sns_topic_arn            = module.sns.sns_topic_arn
}

module "sns" {
  source = "./SNS"
}

module "cloudwatch" {
  source        = "./Monitoring/Cloudwatch"
  asg_name      = module.autoscaling.name
  vpc_id        = module.vpc.vpc_id
  iam_role_arn  = module.iam.dr-cloudwatch-role-arn
  alb_name      = module.elb.alb_name
  sns_topic_arn = module.sns.sns_topic_arn
}

module "backup" {
  source             = "./storage/AWS Backup"
  dr-backup-role-arn = module.iam.dr-backup-role-arn
}

module "s3" {
  source               = "./storage/s3"
  replication_role_arn = module.iam.dr-s3-replication-role-arn
}

module "route53" {
  source                = "./Network/Route 53"
  alb_name              = module.elb.alb_name
  alb_zone_id           = module.elb.alb_zone_id
  alb_dns_name          = module.elb.aws_lb_dns_name
  cloudwatch_alarm_name = module.cloudwatch.cloudwatch_log_group_name
}

module "global_accelerator" {
  source  = "./Network/AWS Global Accelerator"
  alb_arn = module.elb.aws_lb_arn
}

module "cloudfront" {
  source       = "./Network/Cloudfront"
  alb_zone_id  = module.elb.alb_zone_id
  alb_dns_name = module.elb.aws_lb_dns_name
  alb_name     = module.elb.alb_name
}
