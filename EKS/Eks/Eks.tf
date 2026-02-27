# Vpc
resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr

    tags = {
      name = "my-vpc"
    }
}


# Subnet
resource "aws_subnet" "private_subnet_1" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.private_subnet_1_cidr
    availability_zone = var.availability_zone_1
    tags = {
        name = "private-subnet-1"
    }
}

resource "aws_subnet" "private_subnet_2" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.private_subnet_2_cidr
    availability_zone = var.availability_zone_2
    tags = {
        name = "private-subnet-2"
    }
}


# iam role for eks cluster
resource "aws_iam_role" "eks_cluster_role" {
    name = "eks-cluster-role"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Principal = {
                    Service = "eks.amazonaws.com"
                }
            }
        ]
    })
}


# Attach the AmazonEKSClusterPolicy to the IAM role
resource "aws_iam_role_policy_attachment" "eks_cluster_role_attachment" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    role       = aws_iam_role.eks_cluster_role.name
}


# Eks cluster  
resource "aws_eks_cluster" "my_cluster" {
    name     = "my-eks-cluster-new"
    version = "1.35"

    access_config {
        authentication_mode = "API"
    }

    role_arn = aws_iam_role.eks_cluster_role.arn

    vpc_config {
    subnet_ids = [
        aws_subnet.private_subnet_1.id,
        aws_subnet.private_subnet_2.id
    ]
  }
  depends_on = [aws_iam_role_policy_attachment.eks_cluster_role_attachment]
  
  timeouts {
    create = "20m"
  }
}

# iam role for nodes
resource "aws_iam_role" "eks_node_role" {
    name = "eks-node-role-new"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Principal = {
                    Service = "ec2.amazonaws.com"
                }
            }
        ]
    })
}

# Attach the AmazonEKSWorkerNodePolicy, AmazonEC2ContainerRegistryReadOnly, and AmazonEKS_CNI_Policy to the IAM role
resource "aws_iam_role_policy_attachment" "eks_node_role_attachment_1" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    role       = aws_iam_role.eks_node_role.name
}
resource "aws_iam_role_policy_attachment" "eks_node_role_attachment_2" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    role       = aws_iam_role.eks_node_role.name
}
resource "aws_iam_role_policy_attachment" "eks_node_role_attachment_3" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    role       = aws_iam_role.eks_node_role.name
}

# Node group
resource "aws_eks_node_group" "my_node_group" {
    cluster_name = aws_eks_cluster.my_cluster.name
    node_group_name = "my-node-group"
    node_role_arn = aws_iam_role.eks_node_role.arn
    subnet_ids = [
        aws_subnet.private_subnet_1.id,
        aws_subnet.private_subnet_2.id
    ]
    scaling_config {
        desired_size = var.desired_size
        max_size     = var.max_size
        min_size     = var.min_size
    }
    instance_types = var.instance_type
    depends_on = [
        aws_iam_role_policy_attachment.eks_node_role_attachment_1, 
        aws_iam_role_policy_attachment.eks_node_role_attachment_2, 
        aws_iam_role_policy_attachment.eks_node_role_attachment_3
    ]
}