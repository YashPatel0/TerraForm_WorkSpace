provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "my_ec2_instance" {
    ami = "ami-051a31ab2f4d498f5"
    instance_type = "t3.small"
    key_name = var.key_name
    vpc_security_group_ids = [var.sg_id]
}

variable "key_name" {
    description = "Name of the AWS key pair to use for the EC2 instance"
    default = "aws_keypair"
}

variable "sg_id" {
  default = "sg-0b680d925bb9efc3f"
}