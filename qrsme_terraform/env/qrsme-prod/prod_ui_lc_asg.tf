locals {
  user_data_restpi = <<EOF
#!/bin/bash
bash /root/deployui.sh
EOF
}

module "prod_ui_lc_asg" {
    source      = "../../modules/lc_asg"
    aws_region = "us-east-1"

  name = "Prod-UI"

  # Launch configuration
  #
  # launch_configuration = "my-existing-launch-configuration" # Use the existing launch configuration
  # create_lc = false # disables creation of launch configuration
  lc_name = "prod_ui_lc_asg"
  image_id                     = "ami-007640634349ffa43"
  instance_type                = "t3a.small"
  key_name                     = "dev_ui"
  security_groups              = module.prod_ui_ec2_sg.this_security_group_id
  recreate_asg_when_lc_changes = true
  iam_instance_profile = module.prod_ui_iam_instance_profiles.name
  user_data_base64 = base64encode(local.user_data_restpi)
  # Auto scaling group
  asg_name                  = "prod_ui_asg"
  vpc_zone_identifier       = [module.prod_vpc.private_subnets[0],module.prod_vpc.private_subnets[1]]
    health_check_type         = "EC2"
  min_size                  = 1
  max_size                  = 2
  desired_capacity          = 1
  wait_for_capacity_timeout = 0
  target_group_arns = module.prod_ui_alb.target_group_arns
    business_tags = {
        Owner = "Perumal Varadharajulu"
        Email = "perumal@strinkit.com"
    }
    technical_tags = {
        Env = "prod"
        Product = "QRSME"
    }
}