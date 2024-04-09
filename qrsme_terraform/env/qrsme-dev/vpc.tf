provider "aws" {
  region = "us-east-1"
}

resource "aws_eip" "nat" {
  count = 0
   tags = {
        Owner = "Perumal Varadharajulu"
        Email = "perumal@strinkit.com"
        Env = "dev"
        Product = "QRSME App"
    } 
}
module "dev_vpc" {
    source      = "../../modules/vpc"
    aws_region = "us-east-1"
    name = "dev-vpc"
    vpcname ="dev-vpc"
    cidr    = "10.8.28.0/24"
    enable_dns_hostnames             = true
    enable_dns_support               = true
    azs = ["us-east-1a","us-east-1b"]
    public_subnets = ["10.8.28.0/26","10.8.28.64/26"]
    #private_subnets = ["10.8.24.64/26","10.8.24.128/26","10.8.24.192/26","10.8.25.0/26"]

    enable_nat_gateway = false
    single_nat_gateway = false
    one_nat_gateway_per_az = true
    #reuse_nat_ips = true
    #external_nat_ip_ids = "${aws_eip.nat.*.id}"    
    business_tags = {
        Owner = "Perumal Varadharajulu"
        Email = "perumal@strinkit.com"
    }
    technical_tags = {
        Env = "dev"
        Product = "QRSME App"
    }
}