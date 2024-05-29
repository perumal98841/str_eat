output "id" {
  description = "The policy's ID"
  value       = aws_iam_role_policy.policy.id
}

output "name" {
  description = "The name of the policy"
  value       = aws_iam_role_policy.policy.name
}

output "policy" {
  description = "The policy document"
  value       = aws_iam_role_policy.policy.policy
}