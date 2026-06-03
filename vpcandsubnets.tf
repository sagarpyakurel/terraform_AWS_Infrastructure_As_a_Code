


resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = var.vpc_name
  }
}


resource "aws_subnet" "my_public_sn" {
  vpc_id                  = aws_vpc.my_vpc.id
  map_public_ip_on_launch = true
  cidr_block              = "10.0.1.0/24"
  tags = {
    Name = var.public_sn

  }
}


resource "aws_subnet" "my_private_sn" {
  vpc_id                  = aws_vpc.my_vpc.id
  map_public_ip_on_launch = false
  cidr_block              = "10.0.2.0/24"
  tags = {
    Name = var.private_sn
  }

}



