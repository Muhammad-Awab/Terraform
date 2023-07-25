resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDSu57D2P0kqLraBfHpdrSkoAKyCTNaxdUMVFhIrHfrLdNXM4YnVM53h00MrEnH11uZzH8rEJ8H2z6phN8RBQ7DGk2EpqtoPDujD0bfLosC1LBEGZmOdzhMoFxEGkMEcg0X1V9XraIJwyKIhX7F5BmIvHMGQF0fbjuBVe94D6ssrs2ipFMGIZx/9UtezX56YeGTw7gxgOC/QDv+qwNqoA0ye/jaeUZ2eb/prwCZfusCrqlP2Cx2XvlBnSvIyrX6PWGeRbZpsHGQ73b/o08JgsOyeu9Vx7/iim+FJuFpjJvk3RbSMY3oPvtckB4P/p0x6PUt053H6iQiJO49JMR4zLwt falcon@falcon"
}
/* Public Instance */
resource "aws_instance" "Instance1" {
  ami = var.ami_id
  instance_type = var.instance_type
  key_name = "aws_key"

  vpc_security_group_ids = [var.security_group_id]
  subnet_id = var.public_subnet_id
  associate_public_ip_address = true

    
  user_data = <<-EOF
#!/bin/bash
sudo apt update -y
sudo apt install nginx -y 
sudo systemctl enable nginx
sudo systemctl start nginx
EOF

tags = {
  Name = "Instance1"
}
}

/* Private Instance */
resource "aws_instance" "Webserver" {
  ami = var.ami_id
  instance_type = var.instance_type
  key_name = "aws_key"

  vpc_security_group_ids = [var.security_group_id]
  subnet_id = var.private_subnet_id
  associate_public_ip_address = false

    
  user_data = <<-EOF
#!/bin/bash
sudo apt update -y
sudo apt install nginx -y 
sudo systemctl enable nginx
sudo systemctl start nginx
EOF

tags = {
  Name = "Instance1"
}
}

