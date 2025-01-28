data "aws_ami" "ubuntu_ami" {
  most_recent = true
  owners      = var.ami_owners

  filter {
    name   = "name"
    values = var.ami_name_filter
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# data "aws_iam_role" "existing_role" {
#   name = "EC2RoleForCodeDeploy"
#   count = try(length(data.aws_iam_role.existing_role.name), 0) > 0 ? 1 : 0
# }

# data "aws_iam_role" "this" {
#   # count              = length(data.aws_iam_role.existing_role[count.index].arn) == 0 ? 1 : 0
#   name               = "EC2RoleForCodeDeploy"
# }

resource "aws_iam_role" "this" {
  name               = "EC2RoleForCodeDeploy"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}
resource "aws_iam_instance_profile" "this" {
  # role = data.aws_iam_role.this.name
  role = aws_iam_role.this.name
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
