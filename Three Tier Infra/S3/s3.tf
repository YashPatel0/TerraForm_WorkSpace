# create a bucker 
resource "aws_s3_bucket" "yash" {
  bucket = var.bucket

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

#  decible public access block
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.yash.bucket

#   block_public_acls       = false
#   block_public_policy     = false
#   ignore_public_acls      = false
#   restrict_public_buckets = false
}

# give bucket policy (it is important for public access)
resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.yash.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.yash.arn}/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.example]
}


# Output the bucket's website endpoint
output "website_endpoint" {
  value       = aws_s3_bucket.yash.website_endpoint
  description = "The URL to access the static website"
}