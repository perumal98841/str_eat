module "sg_prod_bastion" {
    source      = "../../modules/securitygroup"
    aws_region = "us-east-2"
    create = "false"
    name = "sg-prod-bastion"
    vpc_id = module.eatzos_prod_vpc.vpc_id
    description = "Security Group for Bastion"
    ingress_with_cidr_blocks = [
    {
      rule        = "rdp-tcp"
      cidr_blocks = "45.251.35.251/32"
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