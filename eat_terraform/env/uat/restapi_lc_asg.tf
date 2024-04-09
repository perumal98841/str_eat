locals {
  user_data_restpi = <<EOF
#!/bin/bash
sudo echo $(aws ecr get-authorization-token --region us-east-2 --output text --query 'authorizationData[].authorizationToken' | base64 -d | cut -d: -f2) | docker login -u AWS 340785533010.dkr.ecr.us-east-2.amazonaws.com --password-stdin
sudo docker pull 340785533010.dkr.ecr.us-east-2.amazonaws.com/eatzos-uat-api:latest
sudo docker run -itd --log-driver=awslogs --log-opt awslogs-region=us-east-2 --log-opt awslogs-group=uat_restapi_log_group_us_east_2 -p 80:8080  340785533010.dkr.ecr.us-east-2.amazonaws.com/eatzos-uat-api:latest
#sudo docker run -itd --log-driver=awslogs --log-opt awslogs-region=us-east-2 --log-opt awslogs-group=uat_restapi_log_group_us_east_2 -p 80:80  340785533010.dkr.ecr.us-east-2.amazonaws.com/eatzos-uat-api:latest
EOF
}

module "uat_restapi_lc_asg" {
    source      = "../../modules/lc_asg"
    aws_region = "us-east-2"

  name = "uat-RestAPI"

  # Launch configuration
  #
  # launch_configuration = "my-existing-launch-configuration" # Use the existing launch configuration
  # create_lc = false # disables creation of launch configuration
  lc_name = "uat_restapi_lc_asg"
  image_id                     = "ami-034245ac9c610e45d"
  instance_type                = "t2.small"
  #key_name                     = module.uat_restapi_ec2_keypair.this_key_pair_key_name
  key_name                     = "uat-restapi-key"
  security_groups              = module.uat_restapi_ec2_sg.this_security_group_id
  recreate_asg_when_lc_changes = true
  iam_instance_profile = module.uat_restapi_iam_instance_profile.name
  user_data_base64 = base64encode(local.user_data_restpi)
  # Auto scaling group
  asg_name                  = "uat_restapi_asg"
  vpc_zone_identifier       = [module.uat_vpc.private_subnets[0],module.uat_vpc.private_subnets[1]]
  health_check_type         = "EC2"
  min_size                  = 1
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0
  target_group_arns = module.uat_restapi_alb.target_group_arns
    business_tags = {
        Owner = "Perumal Varadharajulu"
        Email = "perumal@strinkit.com"
    }
    technical_tags = {
        Env = "uat"
        Product = "eatzos App"
    }
}