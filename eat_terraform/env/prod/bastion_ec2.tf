module "prod_bastion" {
    source      = "../../modules/ec2"
    instance_count = 0
    name          = "PROD-Windows-Bastion"
  ami           = "ami-09a54e7baef19d5f4"
  instance_type = "t3a.small"
  subnet_id     = tolist(module.prod_vpc.public_subnets)[0]
#  private_ips                 = ["10.8.24.10"]
  vpc_security_group_ids      =   module.prod_bastion_ec2_sg.this_security_group_id
  associate_public_ip_address = true
    business_tags = {
        Owner = "Perumal Varadharajulu"
        Email = "perumal@strinkit.com"
    }
    technical_tags = {
        Env = "prod"
        Product = "eatzos App"
    } 
    
}