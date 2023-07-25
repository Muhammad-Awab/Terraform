terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  required_version = ">= 0.14.0"
}
provider aws {
  region = "us-east-1"
}

locals {
   ingress_rules = [{
      port        = 443
      description = "Ingress rules for port 443"
   },
   {
      port        = 80
      description = "Ingree rules for port 80"
   }]
}

resource "aws_instance" "ec2_example" {

    ami = "ami-053b0d53c279acc90"  
    instance_type = "t2.micro" 
    key_name= "aws_key"
    vpc_security_group_ids = [aws_security_group.main.id]

  provisioner "file" {
    source      = "/home/falcon/terraform/terraform/file_Provisioner/test.txt"
    destination = "/home/ubuntu/test.txt"
  }
  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("/home/falcon/terraform/terraform/file_Provisioner/id_rsa")
      timeout     = "4m"
   }
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 dynamic "ingress" {
    for_each = local.ingress_rules
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
   
 }
}
tags = {
    Name = "Aws securoty group dynamic block"
  }
}
resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDSu57D2P0kqLraBfHpdrSkoAKyCTNaxdUMVFhIrHfrLdNXM4YnVM53h00MrEnH11uZzH8rEJ8H2z6phN8RBQ7DGk2EpqtoPDujD0bfLosC1LBEGZmOdzhMoFxEGkMEcg0X1V9XraIJwyKIhX7F5BmIvHMGQF0fbjuBVe94D6ssrs2ipFMGIZx/9UtezX56YeGTw7gxgOC/QDv+qwNqoA0ye/jaeUZ2eb/prwCZfusCrqlP2Cx2XvlBnSvIyrX6PWGeRbZpsHGQ73b/o08JgsOyeu9Vx7/iim+FJuFpjJvk3RbSMY3oPvtckB4P/p0x6PUt053H6iQiJO49JMR4zLwt falcon@falcon"
}