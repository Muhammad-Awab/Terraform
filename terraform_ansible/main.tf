terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>4.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}
locals {
  vpc_id = "vpc-04223102aea9d1b6d"
  subnet_id = "subnet-0081579f17863df38"
  private_key = file("/home/falcon/keys/ansible.pem")
}
resource "aws_instance" "nginxinstance" {
  ami="ami-053b0d53c279acc90"
  subnet_id="${local.subnet_id}"
  security_groups= ["sg-0d6d6d68c0515043f"]
  associate_public_ip_address=true
  instance_type="t2.micro"
  key_name= "ansible"
  tags= {
    Name="Test"
  }
  provisioner "remote-exec" {
  inline = [ "echo 'wait for execution'" ]
  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("/home/falcon/keys/ansible.pem")
      timeout     = "1m"
   }
  }
  provisioner "local-exec" {
  //command = "ansible-playbook -i ${aws_instance.nginxinstance.public_ip} , --private-key ${local.private_key} nginx.yml"
  command = "ansible-playbook -i ${aws_instance.nginxinstance.public_ip}, --private-key /home/falcon/keys/ansible.pem nginx.yml"

  }
} 
output "nginxip" {
  value = aws_instance.nginxinstance.public_ip
}

