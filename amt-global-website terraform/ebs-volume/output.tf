output "volume_id" {
  description = "The ID of the attached EBS volume"
  value       = aws_ebs_volume.Amalitech-Website-volume.id
}

output "volume_size" {
  description = "The size of the attached EBS volume"
  value       = aws_ebs_volume.Amalitech-Website-volume.size
}