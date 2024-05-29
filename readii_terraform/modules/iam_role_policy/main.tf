resource "aws_iam_role_policy" "policy" {
  name        = var.policy_name
  policy = var.policy
  role = var.role
}