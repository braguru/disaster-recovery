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


resource "aws_autoscaling_group" "DR-Auto-Scaling-Group" {
  name                      = var.Auto-Scaling-Group-Name
  desired_capacity          = var.desired_capacity
  max_size                  = var.max_size
  min_size                  = var.min_size
  vpc_zone_identifier       = var.subnet_ids
  target_group_arns         = var.target_group_arns
  health_check_type         = "ELB"
  health_check_grace_period = 300
  termination_policies      = ["OldestInstance"]

  launch_template {
    id      = aws_launch_template.DR-Launch-Template.id
    version = "$Latest"
  }
}

resource "aws_launch_template" "DR-Launch-Template" {
  name_prefix   = var.Launch-Template-Name
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_pair_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [var.aws_security_group]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = var.tag,
      Backup = "true"
    }
  }

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size           = 24
      volume_type           = "gp3"
      delete_on_termination = true
    }
  }
  user_data = base64encode(<<-EOF
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

              cat <<'EOL' > /scripts/install_ssm.sh
              ${file("${path.module}/../scripts/install_ssm.sh")}
              EOL

              # Make scripts executable
              chmod +x /scripts/*.sh

              # Execute scripts in sequence
              /scripts/install_docker.sh
              /scripts/install_nginx.sh
              /scripts/install_certbot.sh
              /scripts/install_ssm.sh
              EOF
  )
}

resource "aws_autoscaling_policy" "cpu_target_tracking" {
  name                   = "cpu-utilization-target-tracking"
  autoscaling_group_name = aws_autoscaling_group.DR-Auto-Scaling-Group.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = var.target_value
  }
}



