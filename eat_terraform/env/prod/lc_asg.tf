locals {
  user_data = <<EOF
#!/bin/bash
#echo $(aws ecr get-authorization-token --region us-east-1 --output text --query 'authorizationData[].authorizationToken' | base64 -d | cut -d: -f2) | docker login -u AWS 187945997467.dkr.ecr.us-east-1.amazonaws.com --password-stdin
#docker pull .dkr.ecr.us-east-1.amazonaws.com/jaas-dev:jaas-v1.3
#docker run -itd --log-driver=awslogs --log-opt awslogs-region=us-east-1 --log-opt awslogs-group=jaas-dev-master-log-us-east-1 -p 80:8080 -p 50000:50000 -v /efs-volume/jaas:/var/jenkins_home 187945997467.dkr.ecr.us-east-1.amazonaws.com/jaas-dev:jaas-v1.3
EOF
}

module "eatzos_lc_asg" {
    source      = "../../modules/lc_asg"
    aws_region = "us-east-2"

  name = "eatzos-prod-lc"

  # Launch configuration
  #
  # launch_configuration = "my-existing-launch-configuration" # Use the existing launch configuration
  # create_lc = false # disables creation of launch configuration
  lc_name = "eatzos-prod-lc"
  image_id                     = "ami-0479bd36bf26fbf03"
  instance_type                = "t3a.small"
  key_name                     = module.keypair-prod-ec2-key.this_key_pair_key_name
  security_groups              = module.sg_restapi.this_security_group_id
  recreate_asg_when_lc_changes = true
  iam_instance_profile = module.eatzos_iam_instance_profile.name
  user_data_base64 = base64encode(local.user_data)
  # Auto scaling group
  asg_name                  = "eatzod-prod-asg"
  vpc_zone_identifier       = [module.eatzos_prod_vpc.private_subnets[0],module.eatzos_prod_vpc.private_subnets[1]]
  health_check_type         = "EC2"
  min_size                  = 1
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0
  target_group_arns = module.eatzos_prod_alb.target_group_arns
    business_tags = {
        Owner = "Perumal Varadharajulu"
        Email = "perumal@strinkit.com"
    }
    technical_tags = {
        Env = "prod"
        Product = "eatzos App"
    }
}