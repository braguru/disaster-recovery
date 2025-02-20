resource "aws_default_subnet" "Amalitech-Website-Subnet" {
  map_public_ip_on_launch = var.map_public_ip_on_launch
  availability_zone       = var.availability_zone

  tags = {
    Name = var.subnet_name
  }
}
