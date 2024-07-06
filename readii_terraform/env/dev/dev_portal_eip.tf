resource "aws_eip_association" "eip_assoc" {
  instance_id   = "module.dev_portal.this_instance_id"
  allocation_id = aws_eip.example.id
}

resource "aws_eip" "example" {
  domain = "vpc"
}