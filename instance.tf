resource "aws_instance" "public_ec2" {
  ami                         = "ami-078f95be0757084a3"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.my_public_sn.id
  vpc_security_group_ids      = [aws_security_group.public_sg.id]
  key_name                    = aws_key_pair.my_key.key_name
  associate_public_ip_address = true
}



resource "aws_instance" "private_ec2" {
  ami                         = "ami-078f95be0757084a3"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.my_private_sn.id
  vpc_security_group_ids      = [aws_security_group.private_sg.id]
  key_name                    = aws_key_pair.my_key.key_name
  associate_public_ip_address = false
}
