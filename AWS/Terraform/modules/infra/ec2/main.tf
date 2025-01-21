data "aws_ami" "ubuntu_ami" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-amd64-server-*"]
  }
}

data "aws_iam_role" "this" {
  name = "EC2RoleForCodeDeploy"
}

resource "aws_iam_instance_profile" "this" {
  name = "EC2RoleForCodeDeploy-InstanceProfile"
  role = data.aws_iam_role.this.name
}

resource "aws_instance" "this" {
  ami                    = data.aws_ami.ubuntu_ami.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet
  vpc_security_group_ids = var.vpc_sg_id
  iam_instance_profile   = aws_iam_instance_profile.this.name

  root_block_device {
    volume_size = var.ebs_root_volume.volume_size
    volume_type = var.ebs_root_volume.volume_type
  }
  tags      = var.tags
  user_data = var.user_data
}
