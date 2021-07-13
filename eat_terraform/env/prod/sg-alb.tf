module "sg_eatzos_alb" {
    source      = "../../modules/securitygroup"
    aws_region = "us-east-1"
    name = "eatzos-prod-sg-alb"
    vpc_id = module.eatzos_prod_vpc.vpc_id
    description = "Security Group for Jenkins-as-a-Service, managed by Terraform"
    ingress_with_cidr_blocks = [
    {
      rule        = "http-80-tcp"
      cidr_blocks = "10.0.0.0/8"
    },
    {
      rule        = "https-443-tcp"
      cidr_blocks = "10.0.0.0/8"
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