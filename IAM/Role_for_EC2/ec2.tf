resource "aws_instance" "my_ec2_instance" {
    ami = "ami-019715e0d74f695be"
    instance_type = "t3.small"
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.my_sg.id]
    tags = {
        Name = "my-terr-ec2-instance"
        env = "dev"
    }
    iam_instance_profile = aws_iam_instance_profile.s3_instance_profile.name
}

resource "aws_security_group" "my_sg" {
    name = "new-sg"
    description = "new security group"
    vpc_id = data.aws_vpc.my_vpc.id

    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 80
        to_port = 80
        protocol = "tcp"
    }
    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
    }
    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 22
        to_port = 22
        protocol = "tcp"
    }
    egress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 0
        to_port = 0
        protocol = -1        
    }
}

data "aws_vpc" "my_vpc" {
    default = true
}

variable "key_name" {
    description = "Name of the AWS key pair to use for the EC2 instance"
    default = "aws_keypair"
}

