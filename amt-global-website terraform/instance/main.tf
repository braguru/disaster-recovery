data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "ubuntu_instance" {
  ami                  = data.aws_ami.ubuntu.id
  instance_type        = var.instance_type
  subnet_id            = var.subnet_id
  key_name             = var.key_pair_name
  security_groups      = var.aws_security_group
  availability_zone    = var.availability_zone
  iam_instance_profile = var.iam_code_deploy_name

  root_block_device {
    volume_size           = 24
    delete_on_termination = true
    volume_type           = "gp3"
  }

  # User data script to install Docker
  user_data = <<-EOF
              #!/bin/bash
              
              # Create scripts directory
              mkdir -p /scripts
              
              # Create and populate the script files
              cat <<'EOL' > /scripts/install_docker.sh
              ${file("${path.module}/../scripts/install_docker.sh")}
              EOL

              cat <<'EOL' > /scripts/install_nginx.sh
              ${file("${path.module}/../scripts/install_nginx.sh")}
              EOL

              cat <<'EOL' > /scripts/install_certbot.sh
              ${file("${path.module}/../scripts/install_certbot.sh")}
              EOL

              cat <<'EOL' > /scripts/install_codedeploy.sh
              ${file("${path.module}/../scripts/install_codedeploy.sh")}
              EOL

              cat <<'EOL' > /scripts/install_aws.sh
              ${file("${path.module}/../scripts/install_aws.sh")}
              EOL

              # Make scripts executable
              chmod +x /scripts/*.sh

              # Execute scripts in sequence
              /scripts/install_docker.sh
              /scripts/install_nginx.sh
              /scripts/install_certbot.sh
              /scripts/install_codedeploy.sh
              /scripts/install_aws.sh
              EOF

  tags = {
    Name = var.tag
  }
}

resource "aws_eip" "Amalitech-Website-EIP" {
  instance = aws_instance.ubuntu_instance.id
  domain   = "vpc"

  tags = {
    Name = "Amalitech-Website-EIP"
  }
}



