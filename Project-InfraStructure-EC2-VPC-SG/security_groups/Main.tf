locals {
  ingress_rules=[{
    port = 22
    description = "SSH"
  },
    {
        port = 80
        description = "HTTP"
    },
    {
        port = 443
        description = "HTTPS"
    }
  ]
}

resource "aws_security_group" "practice-SGP" {
  vpc_id = var.vpc_id
  description = "Allow outbound traffic"
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
        from_port = ingress.value.port
        to_port = ingress.value.port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
     }
   }
   tags = {
     Name = "practice-SGP"
   }
}