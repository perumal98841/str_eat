provider "aws" {
  region = "us-east-2"
}

resource "aws_eip" "nat" {
  count = 2
   tags = {
        Owner = "Perumal Varadharajulu"
        Email = "perumal@strinkit.com"
        Env = "uat"
        Product = "eatzos App"
    } 
}
module "uat_vpc" {
    source      = "../../modules/vpc"
    aws_region = "us-east-2"
    name = "uat-vpc"
    vpcname ="uat-vpc"
    cidr    = "10.8.26.0/23"
    enable_dns_hostnames             = true
    enable_dns_support               = true
    azs = ["us-east-2a","us-east-2b"]
    public_subnets = ["10.8.26.0/27","10.8.26.32/27"]
    private_subnets = ["10.8.26.64/26","10.8.26.128/26","10.8.26.192/26","10.8.27.0/26"]

    enable_nat_gateway = true
    single_nat_gateway = false
    one_nat_gateway_per_az = true
    reuse_nat_ips = true
    external_nat_ip_ids = "${aws_eip.nat.*.id}"    
    business_tags = {
        Owner = "Perumal Varadharajulu"
        Email = "perumal@strinkit.com"
    }
    technical_tags = {
        Env = "uat"
        Product = "eatzos App"
    }
}