module "dev_ui" {
    source      = "../../modules/ec2"
    instance_count = 1
    name          = "PROD-Windows-Bastion"
  ami           = "ami-09a54e7baef19d5f4"
  instance_type = "t3a.small"
  subnet_id     = tolist(module.dev_vpc.public_subnets)[0]
#  private_ips                 = ["10.8.24.10"]
  vpc_security_group_ids      =   module.dev_ui_ec2_sg.this_security_group_id
  associate_public_ip_address = true
    business_tags = {
        Owner = "Perumal Varadharajulu"
        Email = "perumal@strinkit.com"
    }
    technical_tags = {
        Env = "dev"
        Product = "QRSME App"
    } 
    
}