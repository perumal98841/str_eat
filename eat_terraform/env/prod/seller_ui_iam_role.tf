module "prod_seller_ui_iam_role" {
  source = "../../modules/iam_role"


  role_name = "prod_seller_ui_iam_role"

  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ec2.amazonaws.com"          
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
}