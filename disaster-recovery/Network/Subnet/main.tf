# Public Subnet in AZ1
resource "aws_subnet" "DR-Public-Subnet-az1" {
  map_public_ip_on_launch = var.map_public_ip_on_launch
  availability_zone       = var.availability_zone_az1
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_block_public_az1
  tags = {
    Name = var.public_subnet_name_az1
  }
}

# Public Subnet in AZ2
resource "aws_subnet" "DR-Public-Subnet-az2" {
  map_public_ip_on_launch = var.map_public_ip_on_launch
  availability_zone       = var.availability_zone_az2
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_block_public_az2
  tags = {
    Name = var.public_subnet_name_az2
  }
}

# Private Subnet 1 in AZ1
resource "aws_subnet" "DR-Private-Subnet-1-az1" {
  map_public_ip_on_launch = var.map_private_ip_on_launch
  availability_zone       = var.availability_zone_az1
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_block_private_az1
  tags = {
    Name = var.private_subnet_name_az1
  }
}

# Private Subnet 2 in AZ2
resource "aws_subnet" "DR-Private-Subnet-2-az2" {
  map_public_ip_on_launch = var.map_private_ip_on_launch
  availability_zone       = var.availability_zone_az2
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_block_private_az2
  tags = {
    Name = var.private_subnet_name_az2
  }
}

# Private Subnet 3 in AZ1
resource "aws_subnet" "DR-Private-Subnet-3-RDS-az1" {
  map_public_ip_on_launch = var.map_private_ip_on_launch
  availability_zone       = var.availability_zone_az1
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_block_private_RDS_az1

  tags = {
    Name = var.private_subnet_name_RDS_az1
  }
}

# Private Subnet 4 in AZ2
resource "aws_subnet" "DR-Private-Subnet-4-RDS-az2" {
  map_public_ip_on_launch = var.map_private_ip_on_launch
  availability_zone       = var.availability_zone_az2
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_block_private_RDS_az2

  tags = {
    Name = var.private_subnet_name_RDS_az2
  }
}

######## DB SUBNET GROUP ########
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = var.db_subnet_group_name
  subnet_ids = [aws_subnet.DR-Private-Subnet-3-RDS-az1.id, aws_subnet.DR-Private-Subnet-4-RDS-az2.id]

  tags = {
    Name = var.db_subnet_group_name
  }
}

######## EIP ########

resource "aws_eip" "DR-EIP-az1" {
  domain = "vpc"
  tags = {
    Name = "${var.DR-EIP}-az1"
  }
}

resource "aws_eip" "DR-EIP-az2" {
  domain = "vpc"
  tags = {
    Name = "${var.DR-EIP}-az2"
  }
}

######## NAT GATEWAY ########

resource "aws_nat_gateway" "DR-NAT-Gateway-az1" {
  allocation_id = aws_eip.DR-EIP-az1.id
  subnet_id     = aws_subnet.DR-Public-Subnet-az1.id
  depends_on = [aws_internet_gateway.DR-Internet-Gateway]

  tags = {
    Name = "${var.DR-NAT-Gateway}-az1"
  }
}

resource "aws_nat_gateway" "DR-NAT-Gateway-az2" {
  allocation_id = aws_eip.DR-EIP-az2.id
  subnet_id     = aws_subnet.DR-Public-Subnet-az2.id
  depends_on = [aws_internet_gateway.DR-Internet-Gateway]

  tags = {
    Name = "${var.DR-NAT-Gateway}-az2"
  }
}


######## INTERNET GATEWAY ########
resource "aws_internet_gateway" "DR-Internet-Gateway" {
  vpc_id = var.vpc_id

  tags = {
    Name = var.DR-Internet-Gateway
  }
}


######## ROUTE TABLES ########
# Public Route Table
resource "aws_route_table" "Public-Route-Table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.destination_cidr_block
    gateway_id = aws_internet_gateway.DR-Internet-Gateway.id
  }

  tags = {
    Name = var.DR-Public-Route-Table
  }
}

# Private Route Table
resource "aws_route_table" "Private-Route-Table-az1" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.destination_cidr_block
    nat_gateway_id = aws_nat_gateway.DR-NAT-Gateway-az1.id
  }

  tags = {
    Name = "${var.DR-Private-Route-Table}-az1"
  }
}

# Private Route Table
resource "aws_route_table" "Private-Route-Table-az2" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.destination_cidr_block
    nat_gateway_id = aws_nat_gateway.DR-NAT-Gateway-az2.id
  }

  tags = {
    Name = "${var.DR-Private-Route-Table}-az2"
  }
}


######## ROUTE TABLE ASSOCIATIONS ########
# Public Route Table Association
resource "aws_route_table_association" "Public_RT_Assoc_az1" {
  subnet_id      = aws_subnet.DR-Public-Subnet-az1.id
  route_table_id = aws_route_table.Public-Route-Table.id
}

resource "aws_route_table_association" "Public_RT_Assoc_az2" {
  subnet_id      = aws_subnet.DR-Public-Subnet-az2.id
  route_table_id = aws_route_table.Public-Route-Table.id
}

# Route Table Associations - Private Subnets
resource "aws_route_table_association" "Private_RT_Assoc_az1" {
  subnet_id      = aws_subnet.DR-Private-Subnet-1-az1.id
  route_table_id = aws_route_table.Private-Route-Table-az1.id
}

resource "aws_route_table_association" "Private_RT_Assoc_az2" {
  subnet_id      = aws_subnet.DR-Private-Subnet-2-az2.id
  route_table_id = aws_route_table.Private-Route-Table-az2.id
}

resource "aws_route_table_association" "Private_RT_RDS_Assoc_az1" {
  subnet_id      = aws_subnet.DR-Private-Subnet-3-RDS-az1.id
  route_table_id = aws_route_table.Private-Route-Table-az1.id
}

resource "aws_route_table_association" "Private_RT_RDS_Assoc_az2" {
  subnet_id      = aws_subnet.DR-Private-Subnet-4-RDS-az2.id
  route_table_id = aws_route_table.Private-Route-Table-az2.id
}