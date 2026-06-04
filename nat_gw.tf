

# resource "aws_eip" "my_eip" {
#   domain = "vpc"
#   tags = {
#   Name = "eip_for_nat_gw" }

# }


# resource "aws_nat_gateway" "my_ngw" {
#   allocation_id = aws_eip.my_eip.id
#   subnet_id     = aws_subnet.my_public_sn.id
#   tags = {
#     Name = "dev_nat_gw"
#   }

# }



