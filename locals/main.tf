terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  required_version = ">= 0.14.0"
}
 provider aws  {
  region = "us-east-1"
}

locals {
  stage = "dev"
}
resource "aws_vpc" "staging-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${local.stage}-vpc-tag"
  }
}
resource "aws_subnet" "staging_subnet" {
  vpc_id = aws_vpc.staging-vpc.id
  cidr_block = "10.0.1.0/24"
  tags ={
    Name = "${local.stage}-subnet-tag"
  }
}
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.staging_subnet.id
    tags = {
      Name = "${local.stage}-instance-tag"
    }
}