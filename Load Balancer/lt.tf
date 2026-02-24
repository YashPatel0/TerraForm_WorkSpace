provider "aws" {
    region = "ap-south-1"
}

resource "aws_launch_template" "home_launch_template"{
    image_id = var.image_id
    instance_type = var.instance_type
    # launch_template_name = "${var.project}-home-lt"
    name = "${var.project}-${var.env}-home-lt"
    key_name = var.key_name
    tags = {
        env = var.env
    }
    vpc_security_group_ids = [aws_security_group.security_group.id]
    user_data = base64encode(<<-EOF
    #!/bin/bash

    # Update system
    apt-get update -y

    # Install Apache
    apt-get install -y apache2

    # Create simple test page
    echo "<h1>Home Page</h1>" > /var/www/html/index.html

    # Enable and start Apache
    systemctl enable apache2
    systemctl start apache2

    EOF
    )
}



resource "aws_launch_template" "laptop_launch_template"{
    image_id = var.image_id
    instance_type = var.instance_type
    name = "${var.project}-${var.env}-laptop-lt"
    key_name = var.key_name
    tags = {
        env = var.env
    }
    vpc_security_group_ids = [aws_security_group.security_group.id]
    user_data = base64encode(<<-EOF

    #!/bin/bash

    # Update system
    apt-get update -y

    # Install Apache
    apt-get install -y apache2

    mkdir /var/www/html/laptop

    # Create simple test page
    echo "<h1>Laptop Page</h1>" > /var/www/html/laptop/index.html

    # Enable and start Apache
    systemctl enable apache2
    systemctl start apache2

    EOF
    )
}

resource "aws_launch_template" "mobile_launch_template"{
    image_id = var.image_id
    instance_type = var.instance_type
    name = "${var.project}-${var.env}-mobile-lt"
    key_name = var.key_name
    tags = {
        env = var.env
    }
    vpc_security_group_ids = [aws_security_group.security_group.id]
    user_data = base64encode(<<-EOF
    #!/bin/bash

    # Update system
    apt-get update -y

    # Install Apache
    apt-get install -y apache2

    mkdir /var/www/html/mobile

    # Create simple test page
    echo "<h1>Mobile Page</h1>" > /var/www/html/mobile/index.html

    # Enable and start Apache
    systemctl enable apache2
    systemctl start apache2

    EOF
    )
}