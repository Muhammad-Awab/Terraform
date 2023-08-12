resource "aws_vpc" "project-vpc" {
  cidr_block = "10.0.0.0/16"

    tags = {
        Name = "project-vpc"
    }
}

resource "aws_subnet" "public_subnet" {
  vpc_id= aws_vpc.project-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet"
  }
}
resource "aws_internet_gateway" "project-igw" {
  vpc_id = aws_vpc.project-vpc.id

  tags = {
    Name = "project-igw"
  }
}
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.project-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project-igw.id
  }
  tags = {
    Name = "public-route-table"
  }
}
resource "aws_route_table_association" "public-route-table-association" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.project-vpc.id  
    cidr_block = "10.0.2.0/24"
    availability_zone = var.availability_zone
    map_public_ip_on_launch = false
    tags = {
        Name = "private_subnet"
    }
}
resource "aws_vpc_endpoint" "s3" {
  vpc_id = aws_vpc.project-vpc.id
  service_name = "com.amazonaws.us-east-1.s3"
  vpc_endpoint_type = "Interface"
  subnet_ids = [aws_subnet.private_subnet.id]
}