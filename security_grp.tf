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
    cidr_blocks = ["71.58.167.103/32"]
  }

  ingress {
    description = "http from anywhere"
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

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
