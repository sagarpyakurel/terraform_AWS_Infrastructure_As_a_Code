resource "aws_route" "route_for_public_sn" {
  route_table_id         = aws_route_table.my_public_rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_igw.id
}
