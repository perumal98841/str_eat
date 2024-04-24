#data "aws_security_group" "prod_ui_alb" {
#  name   = module.prod_ui_alb_sg.this_security_group_name[0]
#  vpc_id = module.prod_vpc.vpc_id
#}

#data "aws_security_group" "prod_ui_bastion" {
#  name   = module.prod_ui_ec2_sg.this_security_group_name[0]
#  vpc_id = module.prod_vpc.vpc_id
#}

module "prod_ui_ec2_sg" {
    source      = "../../modules/securitygroup"
    aws_region = "us-east-1"
    name = "prod_ui_ec2_sg"
    vpc_id = module.prod_vpc.vpc_id
    description = "Security Group for prod UI EC2"
    ingress_with_cidr_blocks = [
    {
      rule        = "ssh-tcp"
      cidr_blocks = "10.8.24.0/28,10.8.24.16/28"
    },
  ]

#      ingress_with_source_security_group_id = [
#    {
#      from_port                = 80
#      to_port                  = 80
#      protocol                 = 6
#      description              = "HTTP"
#      source_security_group_id = data.aws_security_group.prod_ui_alb.id
#    },
#    {
#      from_port                = 22
#      to_port                  = 22
#      protocol                 = 6
#      description              = "SSH"
#      source_security_group_id = data.aws_security_group.prod_ui_bastion.id
#    },
#  ]


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
        Env = "prod"
        Product = "QRSME App"
    }
}