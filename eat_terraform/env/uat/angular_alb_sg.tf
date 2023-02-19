module "uat_angular_alb_sg" {
    source      = "../../modules/securitygroup"
    aws_region = "us-east-2"
    name = "uat_angular_alb_sg"
    vpc_id = module.uat_vpc.vpc_id
    description = "Security Group for angular ALB"
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
        Env = "uat"
        Product = "eatzos App"
    }
}