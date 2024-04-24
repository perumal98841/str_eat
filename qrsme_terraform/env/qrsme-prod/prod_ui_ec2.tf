module "prod_ui" {
    source      = "../../modules/ec2"
    instance_count = 0
    name          = "prod_UI_EC2"
  ami           = "ami-0a297af3ff7c26ba7"
  instance_type = "t3a.small"
  subnet_id     = tolist(module.prod_vpc.public_subnets)[0]
#  private_ips                 = ["10.8.24.10"]
  vpc_security_group_ids      =   module.prod_ui_ec2_sg.this_security_group_id
  associate_public_ip_address = true
    business_tags = {
        Owner = "Perumal Varadharajulu"
        Email = "perumal@strinkit.com"
    }
    technical_tags = {
        Env = "prod"
        Product = "QRSME App"
    } 
    
}