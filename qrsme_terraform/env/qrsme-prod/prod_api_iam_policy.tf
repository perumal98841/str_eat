data "aws_iam_policy_document" "prod_api_ecr_policy" {
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

data "aws_iam_policy_document" "prod_api_logs_policy" {
  statement {
    sid       = "AllowAccessCloudWatchLogs"
    actions   = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = ["*"]
  }
}

module "prod_api_iam_policy_ecr" {
  source = "../../modules/iam_role_policy"
  policy_name = "prod_api_iam_policy_ecr"
  policy = data.aws_iam_policy_document.prod_api_ecr_policy.json
  role = module.prod_api_iam_role.id
}

module "prod_api_iam_policy_logs" {
  source = "../../modules/iam_role_policy"
  policy_name = "prod_api_iam_policy_logs"
  policy = data.aws_iam_policy_document.prod_api_logs_policy.json
  role = module.prod_api_iam_role.id
}