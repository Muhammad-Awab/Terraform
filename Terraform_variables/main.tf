terraform {
  required_providers {
    aws= {
        source = "hashicorp/aws"
        version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}
provider "aws" {
region = "us-east-1"
}

resource "aws_instance" "name" {
  ami = "ami-0c55b159cbfafe1f0"
  instance_type = var.instance_type
  tags = {
    Name = var.environment
  }
}