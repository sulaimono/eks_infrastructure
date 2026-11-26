# VPC
resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# 2 Public Subnets and 2 Private Subnets
# 1st Public Subnet
resource "aws_subnet" "public1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.pub_subnet1_cidr_block
  availability_zone = "${var.aws_region}a"

  tags = {
    (var.k8s_role_elb) = "1"
    Name               = "${var.project_name}-pub-1"
  }

}

# 2nd Public Subnet
resource "aws_subnet" "public2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.pub_subnet2_cidr_block
  availability_zone = "${var.aws_region}b"

  tags = {
    (var.k8s_role_elb) = "1"
    Name               = "${var.project_name}-pub-2"
  }

}

# 1st Private Subnet
resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.priv_subnet1_cidr_block
  availability_zone = "${var.aws_region}a"

  tags = {
    (var.k8s_role_internal_elb) = "1"
    Name                        = "${var.project_name}-priv-1"
  }

}

# 2nd Private Subnet
resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.priv_subnet2_cidr_block
  availability_zone = "${var.aws_region}b"

  tags = {
    (var.k8s_role_internal_elb) = "1"
    Name                        = "${var.project_name}-priv-2"
  }

}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

# Elastic IP
resource "aws_eip" "this" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.gw]

  tags = {
    Name = "${var.project_name}-eip"
  }
}

# NAT gateway
resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = aws_subnet.public1.id

  depends_on = [aws_internet_gateway.gw]

  tags = {
    Name = "${var.project_name}-nat-gw"
  }
}

# Public Route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-pub-rt"
  }
}

# Route for the Public Route
resource "aws_route" "pub_r" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

#Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-priv-rt"
  }
}

# Route for private subnet
resource "aws_route" "priv_r" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this.id
}

# 4 Route table association linking the 4 subnets to the Public and Private Route Table
resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.private.id
}