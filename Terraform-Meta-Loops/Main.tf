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

variable "user_name" {
  description = "IAM Usernames"
  type = list(string)
  default = ["user1", "user2", "user3"]
}
resource "aws_iam_user" "iam_user" {
  count = length(var.user_name)
  name = var.user_name[count.index]
}
  output "user_names" {
    value = [for name in var.user_name: name]
  }


/* locals {
  instance_names = toset(["webserver1", "webserver2", "webserver3"])
}
resource "aws_instance" "aws_ec2_test" {
    for_each = local.instance_names
    ami = "ami-053b0d53c279acc90"
    instance_type = "t2.micro"
    tags = {
        Name = each.key
    }
}
 */
/*  
locals {
  instances = {
    webserver1 = {
      ami = "ami-053b0d53c279acc90"
      instance_type = "t2.micro"
    }
    webserver2 = {
      ami = "ami-053b0d53c279acc90"
      instance_type = "t2.micro"
    }

    webserver3 = {
      ami = "ami-053b0d53c279acc90"
      instance_type = "t2.micro"
    }
  }
}
resource "aws_instance" "name" {
  for_each = local.instances
  ami= each.value.ami
  instance_type = each.value.instance_type
  tags = {
    Name = each.key
  }
} */