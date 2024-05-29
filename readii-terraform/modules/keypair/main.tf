resource "aws_key_pair" "this" {
  key_name        = var.key_name
  public_key      = var.public_key

  tags = merge(
    {
      "Name" = format("%s", var.key_name)
    },
    var.business_tags,
    var.technical_tags,
  )
}