resource "aws_route" "route_for_public_sn" {
  route_table_id         = aws_route_table.my_public_rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_igw.id
}


resource "aws_route" "route_for_private_sn" {
  route_table_id         = aws_route_table.my_private_rtb.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.my_ngw.id
}




