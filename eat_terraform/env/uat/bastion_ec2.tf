module "uat_bastion" {
    source      = "../../modules/ec2"
    instance_count = 1
    name          = "uat-Windows-Bastion"
  ami           = "ami-0d8c33aab5be9b992"
  instance_type = "t3a.small"
  subnet_id     = tolist(module.uat_vpc.public_subnets)[0]
#  private_ips                 = ["10.8.26.10"]
  vpc_security_group_ids      =   module.uat_bastion_ec2_sg.this_security_group_id
  associate_public_ip_address = true
    business_tags = {
        Owner = "Perumal Varadharajulu"
        Email = "perumal@strinkit.com"
    }
    technical_tags = {
        Env = "uat"
        Product = "eatzos App"
    } 
    
}