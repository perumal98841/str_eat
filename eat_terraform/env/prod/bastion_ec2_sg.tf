module "prod_bastion_ec2_sg" {
    source      = "../../modules/securitygroup"
    aws_region = "us-east-2"
    create = "true"
    name = "prod_bastion_ec2_sg"
    vpc_id = module.prod_vpc.vpc_id
    description = "Security Group for Bastion"
    ingress_with_cidr_blocks = [
    {
      rule        = "rdp-tcp"
      cidr_blocks = "49.37.209.63/32"
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