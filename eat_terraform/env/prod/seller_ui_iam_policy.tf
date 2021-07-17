data "aws_iam_policy_document" "ecr_policy" {
  statement {
    sid       = "AllowAccessECR"
    actions   = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:CompleteLayerUpload",
      "ecr:GetAuthorizationToken",
      "ecr:UploadLayerPart",
      "ecr:InitiateLayerUpload",
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer",
      "ecr:PutImage",
    ]
    resources = ["*"]
  }
}

module "prod_seller_ui_iam_policy_ecr" {
  source = "../../modules/iam_role_policy"
  policy_name = "prod_seller_ui_iam_policy_ecr"
  policy = data.aws_iam_policy_document.ecr_policy.json
  role = module.prod_seller_ui_iam_role.id
}
