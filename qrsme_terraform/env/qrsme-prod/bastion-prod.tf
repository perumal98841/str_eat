module "prod_bastion" {
    source      = "../../modules/ec2"

    instance_count = 1
    name          = "PROD-Bastion"
  ami           = "ami-0f496107db66676ff"
  instance_type = "t3a.small"
  subnet_id     = tolist(module.prod_vpc.public_subnets)[0]
  vpc_security_group_ids      =   module.prod_bastion_sg.this_security_group_id
  key_name = "prod-bastion"
    business_tags = {
        Owner = "Perumal Varadharajulu"
        Email = "perumal@strinkit.com"
    }
    technical_tags = {
        Env = "prod"
        Product = "QRSME App"
    }
    
}