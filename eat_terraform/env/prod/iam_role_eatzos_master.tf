module "eatzos_iam_role_master" {
  source = "../../modules/iam_role"


  role_name = "eatzos-master-role"

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