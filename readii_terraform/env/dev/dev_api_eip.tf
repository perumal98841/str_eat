resource "aws_eip_association" "eip_assoc2" {
  instance_id   = module.dev_api.id
  allocation_id = aws_eip.example2.id
}

resource "aws_eip" "example2" {
  domain = "vpc"
tags = {
    Name = "DEV_API_EIP"
  }
}