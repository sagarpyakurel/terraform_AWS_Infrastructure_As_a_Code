
locals {
  publickey_path = "/Users/sagarpyakurel/.ssh/ssh_key.pub"

}

resource "aws_key_pair" "my_key" {
  key_name   = "ssh_key"
  public_key = file(local.publickey_path)
}



