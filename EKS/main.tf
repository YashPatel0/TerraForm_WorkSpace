provider "aws" {
  region = "ap-south-1"
}

module "eks" {
    source = "./Eks"

    #vpc
    vpc_cidr = var.vpc_cidr
    private_subnet_1_cidr = var.private_subnet_1_cidr
    availability_zone_1 = var.availability_zone_1
    private_subnet_2_cidr = var.private_subnet_2_cidr
    availability_zone_2 = var.availability_zone_2
    #eks cluster
    instance_type = var.instance_types
    desired_size = var.desired_size
    max_size = var.max_size
    min_size = var.min_size
}