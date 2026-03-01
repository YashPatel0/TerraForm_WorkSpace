module "EC2" {
  
  source = "./EC2"

    ami_id = var.ami_id
    # ami_id = "ami-0c55b159cbfafe1f0" 
    instance_type = var.instance_type
    # instance_type = "t2.micro"
    key_name = var.key_name
    # key_name = "my-key-pair"
    security_group_id = var.security_group_id
    # security_group_id = module.VPC.security_group_id
    associate_public_ip = var.associate_public_ip
    # associate_public_ip = true
    tagname = var.tagname
    # tagname = "my-ec2-instance"
}

module "VPC" {
  source = "./VPC"

  project_name = var.project_name
  # project_name = "my-terraform-project"
  env = var.env
  # env = "dev" 
  vpc_cidr = var.vpc_cidr
  # vpc_cidr =10.0.0.0/16       
  public_subnet_cidr  = var.public_subnet_cidr
  # public_subnet_cidr = 10.5.5.5/24
  private_subnet_cidr = var.private_subnet_cidr
  # private_subnet_cidr 10.5.5.5/24
  allowed_http_cidr =  var.allowed_http_cidr
  # allowed_http_cidr = 0.0.0.0/0
  allowed_ssh_cidr = var.allowed_ssh_cidr
  # allowed_ssh_cidr = 0.0.0.0/0
}

module "RDS" {
  source = "./RDS"

  project_name = var.project_name
  env = var.env
  subnet_ids = [module.VPC.public_subnet_id, module.VPC.private_subnet_id]
  security_group_id = module.VPC.security_group_id
  engine = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class
  allocated_storage = var.allocated_storage
  db_name = var.db_name
  username = var.username
  password = var.password
}

module "EKS" {
  source = "./Eks"

  vpc_cidr = var.vpc_cidr
  private_subnet_1_cidr = var.private_subnet_1_cidr
  availability_zone_1 = var.availability_zone_1
  private_subnet_2_cidr = var.private_subnet_2_cidr
  availability_zone_2 = var.availability_zone_2
  instance_type = var.instance_type
  desired_size = var.desired_size
  max_size = var.max_size
  min_size = var.min_size
}
