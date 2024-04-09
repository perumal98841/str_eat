output "id" {
  description = "The policy's ID"
  value       = aws_iam_role.this.id
}

output "arn" {
  description = "The ARN assigned by AWS to this policy"
  value       = aws_iam_role.this.arn
}

output "description" {
  description = "The description of the policy"
  value       = aws_iam_role.this.description
}

output "name" {
  description = "The name of the policy"
  value       = aws_iam_role.this.name
}