variable "ami_id" {
  default = "ami-019715e0d74f695be"
}

variable "instance_type" {
  default = "t2.micro"
}
variable "key_name" {
  default = "aws_keypair"
}
variable "tagname" {
  default = "my_project"
}
variable "security_group_id" {}


variable "associate_public_ip" {}

