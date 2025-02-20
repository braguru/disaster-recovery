resource "aws_route_table" "Amalitech-Website-Route-Table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.destination_cidr_block
    gateway_id = data.aws_internet_gateway.default.id
  }

  tags = {
    Name = var.route_table_name
  }
}


data "aws_internet_gateway" "default" {
  filter {
    name   = "attachment.vpc-id"
    values = [var.vpc_id]
  }
}

resource "aws_route_table_association" "main" {
  subnet_id      = var.subnet_id
  route_table_id = aws_route_table.Amalitech-Website-Route-Table.id
}
