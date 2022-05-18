# Create a vpc in us-east-1
resource "aws_vpc" "PAC-7" {
  provider             = aws.region-us-east-1
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    "Name" = "PAC-7-vpc"
  }
}

# Create a subnet in us-east-1
resource "aws_subnet" "PAC-7-subnet" {
  provider          = aws.region-us-east-1
  availability_zone = var.aws_az
  vpc_id            = aws_vpc.PAC-7.id
  cidr_block        = "10.0.0.0/24"
  tags = {
    "Name" = "PAC-7-subnet"
  }
}

# Create a Internet Gateway in us-east-1
resource "aws_internet_gateway" "PAC-7-IGW" {
  provider = aws.region-us-east-1
  vpc_id   = aws_vpc.PAC-7.id
  tags = {
    "Name" = "PAC-7-Gateway"
  }
}

# Create the route table us-east-1
resource "aws_route_table" "PAC-7-route" {
  provider = aws.region-us-east-1
  vpc_id   = aws_vpc.PAC-7.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.PAC-7-IGW.id
  }
  lifecycle {
    ignore_changes = all
  }
  tags = {
    "Name" = "PAC-7-route"
  }
}

# Associate the route table with the vpc
resource "aws_main_route_table_association" "route_vpc" {
  provider       = aws.region-us-east-1
  vpc_id         = aws_vpc.PAC-7.id
  route_table_id = aws_route_table.PAC-7-route.id
}