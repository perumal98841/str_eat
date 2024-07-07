data "aws_security_group" "dev_api_ec2_sg_data" {
  name   = module.dev_api_ec2_sg.this_security_group_name[0]
  vpc_id = module.dev_vpc.vpc_id
}

#data "aws_security_group" "dev_portal_bastion" {
#  name   = module.prod_bastion_ec2_sg.this_security_group_name[0]
#  vpc_id = module.dev_vpc.vpc_id
#}

module "dev_portal_ec2_sg" {
    source      = "../../modules/securitygroup"
    aws_region = "us-east-1"
    name = "dev_portal_ec2_sg"
    vpc_id = module.dev_vpc.vpc_id
    description = "Security Group for dev_portal EC2"
    ingress_with_cidr_blocks = [
    {
      rule        = "http-80-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

      ingress_with_source_security_group_id = [
    {
      from_port                = 9001
      to_port                  = 9001
      protocol                 = 6
      description              = "HTTP"
      source_security_group_id = data.aws_security_group.dev_api_ec2_sg_data.id
    }
#    {
#      from_port                = 22
#      to_port                  = 22
#      protocol                 = 6
#      description              = "SSH"
#      source_security_group_id = data.aws_security_group.dev_portal_bastion.id
#    },
  ]


    egress_with_cidr_blocks = [
    {
      rule        = "all-all"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
    business_tags = {
        Owner = "Perumal Varadharajulu"
        Email = "perumal@strinkit.com"
    }
    technical_tags = {
        Env = "dev"
        Product = "Readii App-Admin Portal"
    }
}