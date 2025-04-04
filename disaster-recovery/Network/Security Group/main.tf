resource "aws_security_group" "Disaster-Recovery-Security-Group" {
  name        = var.sg_name
  description = "Security Group for Disaster-Recovery-Instance"
  vpc_id      = var.vpc_id

  tags = var.tag
}

# Allow SSH access from the provided CIDR blocks
resource "aws_vpc_security_group_ingress_rule" "ssh_access" {
  security_group_id = aws_security_group.Disaster-Recovery-Security-Group.id
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = var.ssh_access
}

# Allow all outbound traffic
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.Disaster-Recovery-Security-Group.id
  ip_protocol       = "-1"
  cidr_ipv4         = var.cidr_ipv4
}

resource "aws_vpc_security_group_ingress_rule" "http_access" {
  security_group_id = aws_security_group.Disaster-Recovery-Security-Group.id
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv4         = var.cidr_ipv4
  
}

resource "aws_vpc_security_group_ingress_rule" "https_access" {
  security_group_id = aws_security_group.Disaster-Recovery-Security-Group.id
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  cidr_ipv4         = var.cidr_ipv4
}

resource "aws_security_group" "rds_sg" {
  name = "rds-sg"
  description = "Security Group for RDS"
  vpc_id = var.vpc_id

  tags = var.tag

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}



