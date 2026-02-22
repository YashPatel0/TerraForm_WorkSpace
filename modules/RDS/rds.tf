# Using default VPC
data "aws_vpc" "rds_vpc" {
  default = true
}

# Using Dafault subnet
data "aws_subnets" "rds_subnet" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.rds_vpc.id]
  }
}

# create a security group for RDS instance
resource "aws_security_group" "my_sg" {
    name = "new-sg"
    description = "new security group"
    vpc_id = data.aws_vpc.rds_vpc.id

    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
    }
    egress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 0
        to_port = 0
        protocol = -1        
    }
    tags = {
        name = "RDS_security_group"
    }
}

# Subnet group for RDS
resource "aws_db_subnet_group" "rds_subne_group_my" {
  name = "db-subnet-group"
  subnet_ids = data.aws_subnets.rds_subnet.ids
  tags = {
    Name = "db-subnet-group"
  }
}

# create an RDS instance
resource "aws_db_instance" "yash_rds_instance" {
    allocated_storage = var.allocated_storage
    max_allocated_storage = var.max_allocated_storage
    db_name = "my_database"
    engine = "mysql"
    engine_version = "8.0"
    instance_class = var.instance_class
    username = var.username
    password = var.password
    skip_final_snapshot = false
    publicly_accessible = true
    vpc_security_group_ids = [aws_security_group.my_sg.id]
    db_subnet_group_name = aws_db_subnet_group.rds_subne_group_my.name
}