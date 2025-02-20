resource "aws_ebs_volume" "Amalitech-Website-volume" {
  availability_zone = var.availability_zone
  size              = var.ebs_volume_size
  type              = var.ebs_type

  tags = {
    Name = var.volume_name
  }
}

# Attach EBS Volume to Instance
resource "aws_volume_attachment" "volume_attach" {
  device_name = var.device_name
  volume_id   = aws_ebs_volume.Amalitech-Website-volume.id
  instance_id = var.aws_instance_id
}
