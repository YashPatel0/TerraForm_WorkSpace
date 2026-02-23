resource "aws_iam_role" "s3_role" {
  name = "demo-s3-role"

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
    role = aws_iam_role.s3_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_instance_profile" "s3_instance_profile" {
  name = "s3-instance-profile"
  role = aws_iam_role.s3_role.name
}