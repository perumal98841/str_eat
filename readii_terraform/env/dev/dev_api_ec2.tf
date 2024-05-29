module "dev_api" {
    source      = "../../modules/ec2"
    instance_count = 1
    name          = "DEV_EC2"
  ami           = "ami-0cf9618d72642d6dd"
  instance_type = "t2.micro"
  key_name = "dev-readii-ec2"
  subnet_id     = tolist(module.dev_vpc.public_subnets)[0]
#  private_ips                 = ["10.8.24.10"]
  vpc_security_group_ids      =   module.dev_api_ec2_sg.this_security_group_id
  associate_public_ip_address = true
    business_tags = {
        Owner = "Perumal Varadharajulu"
        Email = "perumal@strinkit.com"
    }
    technical_tags = {
        Env = "dev"
        Product = "Readii App"
    } 
    
}