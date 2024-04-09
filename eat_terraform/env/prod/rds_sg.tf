data "aws_security_group" "rds_restapi_ec2" {
  name   = module.prod_restapi_ec2_sg.this_security_group_name[0]
  vpc_id = module.prod_vpc.vpc_id
}

data "aws_security_group" "rds_bastion_ec2" {
  name   = module.prod_bastion_ec2_sg.this_security_group_name[0]
  vpc_id = module.prod_vpc.vpc_id
}

module "prod_rds_sg" {
    source      = "../../modules/securitygroup"
    aws_region = "us-east-2"
    name = "prod_rds_sg"
    vpc_id = module.prod_vpc.vpc_id
    description = "Security Group for RDS"

      ingress_with_source_security_group_id = [
    {
      from_port                = 5432
      to_port                  = 5432
      protocol                 = 6
      description              = "RDS Port for RestAPI"
      source_security_group_id = data.aws_security_group.rds_restapi_ec2.id
    },
    {
      from_port                = 5432
      to_port                  = 5432
      protocol                 = 6
      description              = "RDS Port for Bastion"
      source_security_group_id = data.aws_security_group.rds_bastion_ec2.id
    },
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
        Env = "prod"
        Product = "eatzos App"
    }
}