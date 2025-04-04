output "sg_id" {
  value = aws_security_group.Disaster-Recovery-Security-Group.id
}

output "sg_arn" {
  value = aws_security_group.Disaster-Recovery-Security-Group.arn
}

output "sg_name" {
  value = aws_security_group.Disaster-Recovery-Security-Group.name
}

output "rds_sg_id" {
  value = aws_security_group.rds_sg.id
}




