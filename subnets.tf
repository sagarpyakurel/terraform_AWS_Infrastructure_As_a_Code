resource "aws_subnet" "sagar_public_subnet" {
  vpc_id     = aws_vpc.sagar_vpc.id
  map_public_ip_on_launch = true
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "sagar-public-subnet"

  }
}

