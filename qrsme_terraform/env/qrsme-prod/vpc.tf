provider "aws" {
  region = "us-east-1"
}

resource "aws_eip" "nat" {
  count = 1
   tags = {
        Owner = "Perumal Varadharajulu"
        Email = "perumal@strinkit.com"
        Env = "prod"
        Product = "QRSME App"
    } 
}
module "prod_vpc" {
    source      = "../../modules/vpc"
    aws_region = "us-east-1"
    name = "prod-vpc"
    vpcname ="prod-vpc"
    cidr    = "10.8.30.0/24"
    enable_dns_hostnames             = true
    enable_dns_support               = true
    azs = ["us-east-1a","us-east-1b"]
    public_subnets = ["10.8.30.0/26","10.8.30.64/26"]
    private_subnets = ["10.8.30.128/26"."10.8.30.192/26"]

    enable_nat_gateway = true
    single_nat_gateway = true
    one_nat_gateway_per_az = false
    reuse_nat_ips = true
    external_nat_ip_ids = "${aws_eip.nat.*.id}"    
    business_tags = {
        Owner = "Perumal Varadharajulu"
        Email = "perumal@strinkit.com"
    }
    technical_tags = {
        Env = "prod"
        Product = "QRSME App"
    }
}