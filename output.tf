output "vpc_cidr_block" {
  value       = aws_vpc.my_vpc.cidr_block
  description = "This is vpc cidr block"
  sensitive   = true
}

output "public_subnet_cidr_block" {
  value       = aws_subnet.my_public_sn.cidr_block
  description = "This is my public subnet cidr block"
}

output "private_subnet_cidr_block" {
  value       = aws_subnet.my_private_sn.cidr_block
  description = "This is my private subnet cidr block"
}


output "sg_for_public" {
  value = aws_security_group.public_sg.id

}

output "public_ec2_public_ip" {
  value = aws_instance.public_ec2.public_ip
}



