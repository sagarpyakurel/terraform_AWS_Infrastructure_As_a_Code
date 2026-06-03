resource "aws_route_table" "my_private_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = var.private_rtb
  }
}

resource "aws_route_table" "my_public_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = var.public_rtb
  }
}





