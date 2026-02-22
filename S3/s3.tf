provider "aws" {
  region = "ap-south-1"
}

# create a bucker
resource "aws_s3_bucket" "yash_s3_bucket" {
    bucket = var.bucket

    tags = {
    Name        = "My bucket"
    Environment = "Practice"
  }
}

#  decible public access block
resource "aws_s3_bucket_public_access_block" "yash_s3_bucket_public_access_block" {
    bucket = aws_s3_bucket.yash_s3_bucket.bucket

    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
}


