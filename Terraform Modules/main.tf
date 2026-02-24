module "EC2" {
  source = "./EC2"

    ami_id = var.ami_id
    instance_type = var.instance_type
    key_name = var.key_name
    security_group_id = var.security_group_id
    associate_public_ip = var.associate_public_ip
    tagname = var.tagname
}

