module "prod_seller_ui_alb_sg" {
    source      = "../../modules/securitygroup"
    aws_region = "us-east-2"
    name = "prod_seller_ui_alb_sg"
    vpc_id = module.prod_vpc.vpc_id
    description = "Security Group for Seller UI ALB"
    ingress_with_cidr_blocks = [
    {
      rule        = "http-80-tcp"
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
        Product = "eatzos App"
    }
}