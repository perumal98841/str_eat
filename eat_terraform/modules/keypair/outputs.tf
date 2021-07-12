output "this_key_pair_key_pair_id" {
  description = "The key pair ID."
  value       = aws_key_pair.this.key_pair_id
}

output "this_key_pair_key_name" {
  description = "The key pair ID."
  value       = aws_key_pair.this.key_name
}