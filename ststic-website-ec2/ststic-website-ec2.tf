provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "my_ec2_instance" {
  ami                    = "ami-019715e0d74f695be"
  instance_type          = "t3.small"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.my_sg.id]

  user_data = <<EOF
#!/bin/bash
apt update -y
apt install apache2 -y
systemctl enable apache2
systemctl start apache2

# Create index.html
cat <<EOT > /var/www/html/index.html
${file("index.html")}
EOT

# Create style.css
cat <<EOT > /var/www/html/style.css
${file("style.css")}
EOT

chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html
systemctl restart apache2
EOF

  tags = {
    Name = "my-terraform-ec2-instance"
    env  = "practice"
  }
}

resource "aws_security_group" "my_sg" {
  name        = "new-sg"
  description = "new security group"
  vpc_id      = data.aws_vpc.my_vpc.id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
}

data "aws_vpc" "my_vpc" {
  default = true
}

variable "key_name" {
  description = "Name of the AWS key pair"
  default     = "aws_keypair"
}

output "public_ip" {
  value = aws_instance.my_ec2_instance.public_ip
}