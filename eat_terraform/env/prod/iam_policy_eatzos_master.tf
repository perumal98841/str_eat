data "aws_iam_policy_document" "master_policy" {
  statement {
    sid       = "AllowSecretManagerAccess"
    actions   = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:ListSecrets",
    ]
    resources = ["*"]
  }
}

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

data "aws_iam_policy_document" "ec2_policy" {
  statement {
    sid       = "AllowAccessEC2"
    actions   = [
      "ec2:DescribeSpotInstanceRequests",
      "ec2:CancelSpotInstanceRequests",
      "ec2:GetConsoleOutput",
      "ec2:RequestSpotInstances",
      "ec2:RunInstances",
      "ec2:StartInstances",
      "ec2:StopInstances",
      "ec2:TerminateInstances",
      "ec2:CreateTags",
      "ec2:DeleteTags",
      "ec2:DescribeInstances",
      "ec2:DescribeKeyPairs",
      "ec2:DescribeRegions",
      "ec2:DescribeImages",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "iam:ListInstanceProfilesForRole",
      "iam:PassRole",
      "ec2:GetPasswordData",
              ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "cloudwatch_policy" {
  statement {
    sid       = "AllowCloudWatchAccess"
    actions   = [
        "logs:CreateLogStream",
        "logs:PutLogEvents",
    ]
    resources = ["*"]
  }
}

module "eatzos_iam_policy_master" {
  source = "../../modules/iam_role_policy"
  policy_name = "eatzos-master-policy"
  policy = data.aws_iam_policy_document.master_policy.json
  role = module.eatzos_iam_role_master.id
}

module "eatzos_iam_policy_master_ecr" {
  source = "../../modules/iam_role_policy"
  policy_name = "eatzos-ecr-policy"
  policy = data.aws_iam_policy_document.ecr_policy.json
  role = module.eatzos_iam_role_master.id
}

module "eatzos_iam_policy_master_ec2" {
  source = "../../modules/iam_role_policy"
  policy_name = "eatzos-ec2-policy"
  policy = data.aws_iam_policy_document.ec2_policy.json
  role = module.eatzos_iam_role_master.id
}

module "jaas_iam_policy_master_cloudwatch" {
  source = "../../modules/iam_role_policy"
  policy_name = "jaas-cloudwatch-policy"
  policy = data.aws_iam_policy_document.cloudwatch_policy.json
  role = module.jaas_iam_role_master.id
}