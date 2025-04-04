output "public_subnet_id_az1" {
  value = aws_subnet.DR-Public-Subnet-az1.id
}

output "public_subnet_id_az2" {
  value = aws_subnet.DR-Public-Subnet-az2.id
}

output "private_subnet_id_az1" {
  value = aws_subnet.DR-Private-Subnet-1-az1.id
}

output "private_subnet_id_az2" {
  value = aws_subnet.DR-Private-Subnet-2-az2.id
}

output "private_subnet_RDS_az1" {
  value = aws_subnet.DR-Private-Subnet-3-RDS-az1.id
}

output "private_subnet_RDS_az2" {
  value = aws_subnet.DR-Private-Subnet-4-RDS-az2.id
}

output "public_subnet_arn_az1" {
  value = aws_subnet.DR-Public-Subnet-az1.arn
}

output "public_subnet_arn_az2" {
  value = aws_subnet.DR-Public-Subnet-az2.arn
}

output "public_subnet_name_az1" {
  value = aws_subnet.DR-Public-Subnet-az1.tags
}

output "public_subnet_cidr_block_az1" {
  value = aws_subnet.DR-Public-Subnet-az1.cidr_block
}

output "public_subnet_cidr_block_az2" {
  value = aws_subnet.DR-Public-Subnet-az2.cidr_block
}

output "public_subnet_name_az2" {
  value = aws_subnet.DR-Public-Subnet-az2.tags
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.rds_subnet_group.name
}

