data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_db_instance" "rds_instance" {
  identifier                  = "rds-instance"
  engine                      = var.engine
  instance_class              = var.instance_class
  allocated_storage           = var.allocated_storage
  db_name                     = var.db_name
  username                    = var.username
  password                    = var.password
  db_subnet_group_name        = var.db_subnet_group_name
  vpc_security_group_ids      = var.vpc_security_group_id
  max_allocated_storage       = var.max_allocated_storage
  multi_az                    = var.multi_az
  availability_zone           = data.aws_availability_zones.available.names[0]
  storage_type                = var.storage_type
  publicly_accessible         = var.publicly_accessible
  backup_retention_period     = var.backup_retention_period
  skip_final_snapshot         = true

  tags = {
    Name = var.name,
    Backup = "true"
  }
}

# Read Replica in a Different AZ
resource "aws_db_instance" "read_replica" {
  identifier             = "read-replica-instance"
  engine                 = var.engine
  instance_class         = var.instance_class
  replicate_source_db    = aws_db_instance.rds_instance.arn # Creates a read replica
  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = var.vpc_security_group_id
  availability_zone      = data.aws_availability_zones.available.names[1]
  publicly_accessible    = false
  skip_final_snapshot    = true

  tags = {
    Name = "ReadReplica",
    Backup = "true"
  }
}
