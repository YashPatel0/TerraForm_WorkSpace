provider "aws" {
  region = var.region
}

module "RDS" {
  source = "./modules/RDS"

  allocated_storage = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  instance_class = var.instance_class
  username = var.username
  password = var.password
}

module "S3" {
  source = "./modules/S3"
  bucket = var.bucket
}