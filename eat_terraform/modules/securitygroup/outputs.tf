output "this_security_group_id" {
  description = "The ID of the security group"
  value = concat(aws_security_group.this.*.id)
}

output "this_security_group_name" {
  description = "The Name of the security group"
  value = concat(aws_security_group.this.*.name)
}