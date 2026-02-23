provider "aws" {
  region = "ap-south-1"
}

resource "aws_iam_role" "demo_role" {
    name = "demo_role"
    assume_role_policy = jsondecode({
        version = "2012-10-17"
        statement = [
            {
                effect = "Allow"
                principal = {
                    service = "ec2.amazonaws.com"
                    }
                action = "sts:AssumeRole"
            }
        ]
    })
}

