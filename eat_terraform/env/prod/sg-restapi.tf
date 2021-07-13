data "aws_security_group" "alb" {
  name   = module.sg_eatzos_alb.this_security_group_name[0]
  vpc_id = module.eatzos_prod_vpc.vpc_id
}

data "aws_security_group" "bastion" {
  name   = module.sg_prod_bastion.this_security_group_name[0]
  vpc_id = module.eatzos_prod_vpc.vpc_id
}

module "sg_restapi" {
    source      = "../../modules/securitygroup"
    aws_region = "us-east-2"
    name = "jaas-dev-sg-jaas-master"
    vpc_id = module.eatzos_prod_vpc.vpc_id
    description = "Security Group for Jenkins-as-a-Service, managed by Terraform"
    ingress_with_cidr_blocks = [
    {
      rule        = "ssh-tcp"
      cidr_blocks = "10.3.138.192/27,10.3.138.32/27,10.8.24.0/28,10.8.24.16/28"
    },
  ]

      ingress_with_source_security_group_id = [
    {
      from_port                = 80
      to_port                  = 80
      protocol                 = 6
      description              = "HTTP"
      source_security_group_id = data.aws_security_group.alb.id
    },
    {
      from_port                = 8080
      to_port                  = 8080
      protocol                 = 6
      description              = "HTTP-Jenkins"
      source_security_group_id = data.aws_security_group.alb.id
    },

    {
      from_port                = 443
      to_port                  = 443
      protocol                 = 6
      description              = "HTTPS"
      source_security_group_id = data.aws_security_group.alb.id
    },
    {
      from_port                = 22
      to_port                  = 22
      protocol                 = 6
      description              = "SSH"
      source_security_group_id = data.aws_security_group.bastion.id
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