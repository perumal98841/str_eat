output "id" {
  description = "The instance profile's ID"
  value       = aws_iam_instance_profile.this.id
}

output "arn" {
  description = "The ARN assigned by AWS to the instance profile"
  value       = aws_iam_instance_profile.this.arn
}

output "name" {
  description = "The instance profile's name"
  value       = aws_iam_instance_profile.this.name
}