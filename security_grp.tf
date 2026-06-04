locals {
  myip = "71.58.167.103/32"
}

resource "aws_security_group" "public_sg" {
  description = "Allow ssh and http"
  vpc_id      = aws_vpc.my_vpc.id
  name        = "dev_public_sg"


  #inbound: ssh from anyone
  ingress {
    description = "shh from my laptop"
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = [local.myip]
  }

  ingress {
    description = "http from anywhere"
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #outbound: can go to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" #allow all
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "dev_public_sg"
  }

}




resource "aws_security_group" "private_sg" {
  vpc_id      = aws_vpc.my_vpc.id
  description = "allow ssh only from Bastion host or Jump Sever"
  name        = "private_sg"

  #inbound 
  ingress {
    protocol        = "tcp"
    from_port       = 22
    to_port         = 22
    security_groups = [aws_security_group.public_sg.id]
    #cidr_blocks=[aws_subnet.my_public_sn.cidr_block]
    description = "can only allowed by public subnet"
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]

  }
}


