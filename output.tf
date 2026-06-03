output "vpc_cidr_block" {
  value       = aws_vpc.my_vpc.cidr_block
  description = "This is vpc cidr block"
}

output "public_subnet_cidr_block" {
  value       = aws_subnet.my_public_sn.cidr_block
  description = "This is my public subnet cidr block"
}

output "private_subnet_cidr_block" {
  value       = aws_subnet.my_private_sn.cidr_block
  description = "This is my private subnet cidr block"
}


