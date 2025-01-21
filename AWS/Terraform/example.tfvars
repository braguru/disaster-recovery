instance_type = "------"
vpc_id        = "vpc------"
subnet        = "subnet------"
sg_name       = "icon-sg"

vpc_sg_ingress = [
  {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

vpc_sg_egress = [
  {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

ebs_root_volume = {
  volume_size = 30
  volume_type = "gp3"
}

bucket_name       = "icon-artifact-dev"
app_name          = "icon"
deployment_groups = ["icon-job-portal", "icon-frontend", "icon-backend"]
repo_name         = "development-repo"
