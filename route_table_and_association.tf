resource "aws_route_table" "my_private_rtb" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = var.private_rtb
  }
}
resource "aws_route_table_association" "private_sn_associates_private_rtb" {
  subnet_id      = aws_subnet.my_private_sn.id
  route_table_id = aws_route_table.my_private_rtb.id
}




resource "aws_route_table" "my_public_rtb" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = var.public_rtb
  }
}



resource "aws_route_table_association" "public_sn_associates_public_rtb" {
  subnet_id      = aws_subnet.my_public_sn.id
  route_table_id = aws_route_table.my_public_rtb.id
}




