provider "aws" {
  region = "ap-south-1"
}

resource "aws_iam_role" "demo_role" {
  name = "demo-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = ""
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "demo_role_policy_attachment" {
    role = aws_iam_role.demo_role.name
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}