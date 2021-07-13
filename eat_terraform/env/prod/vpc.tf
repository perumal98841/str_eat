provider "aws" {
  region = "us-east-2"
}

resource "aws_eip" "nat" {
  count = 1
   tags = {
        Owner = "Perumal Varadharajulu"
        Email = "perumal@strinkit.com"
        Env = "prod"
        Product = "eatzos App"
    } 
}
module "eatzos_prod_vpc" {
    source      = "../../modules/vpc"
    aws_region = "us-east-2"
    name = "eatzos-prod"
    vpcname ="eatzos-prod-vpc"
    cidr    = "10.8.24.0/23"
    enable_dns_hostnames             = true
    enable_dns_support               = true
    azs = ["us-east-2a","us-east-2b"]
    public_subnets = ["10.8.24.0/27","10.8.24.32/27"]
    private_subnets = ["10.8.24.64/26","10.8.24.128/26","10.8.24.192/26","10.8.25.0/26"]

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
        Env = "prod"
        Product = "eatzos App"
    }
}