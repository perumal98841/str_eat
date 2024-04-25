module "prod_bastion_sg" {
    source      = "../../modules/securitygroup"
    aws_region = "us-east-1"
    name = "prod-bastion-sg"
    vpc_id = module.prod_vpc.vpc_id
    description = "Security Group for QRSME Bastion, managed by Terraform"
    ingress_with_cidr_blocks = [
    {
      rule        = "rdp-tcp"
      cidr_blocks = "0.0.0.0/0"
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
        Product = "QRSME App"
    }
}