output "this_instance_id" {
  description = "The ID of the Instance"
  value = concat(aws_instance.this.*.id)
}