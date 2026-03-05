provider "aws" {
  region = "ap-south-1"
}



module "EKS" {
#   Path to the EKS module
  source = "./EKS"

  aws_eks_cluster_name = "my-eks-cluster"
#   EKS Node Group scaling 
  desired_size = 2
  max_size = 3
  min_size = 1

#   EKS Node Group instance types
  instance_types =  ["t2.small"]
 
}


module "RDS" {
  source = "./RDS"

  allocated_storage = 10
  max_allocated_storage = 20
  instance_class = "db.t3.micro"
  username = "admin"
  password = "admin"
}


module "s3" {
  source = "./S3"

  bucket = "yash-bucket-123"
}