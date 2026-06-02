


resource "aws_vpc" "sagar_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags={
    Name = var.vpc_name
  }
}


resource "aws_subnet" "sagar_public_subnet" {
  vpc_id     = aws_vpc.sagar_vpc.id
  map_public_ip_on_launch = true
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "sagar-public-subnet"

  }
}

