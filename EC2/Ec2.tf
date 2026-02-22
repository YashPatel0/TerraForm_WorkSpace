provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "my_ec2_instance" {
    ami = "ami-019715e0d74f695be"
    instance_type = "t3.small"
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.my_sg.id]
    tags = {
        Name = "my-terr-ec2-instance"
        env = "dev"
    }
    # heredoc
    user_data = <<EOF
#!/bin/bash

# Update system
apt-get update -y

# Install Apache
apt-get install -y apache2

# Create simple test page
echo "<h1>Deployed using Terraform</h1>" > /var/www/html/index.html

# Enable and start Apache
systemctl enable apache2
systemctl start apache2

EOF

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

output "public_ip" {
    value = aws_instance.my_ec2_instance.public_ip
}
