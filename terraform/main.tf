provider "aws" {
  region = "us-east-1"
}

# Create the S3 bucket
resource "aws_s3_bucket" "s3Bucket" {
  bucket = "my-terraform-with-cicd"
  acl    = null

  website {
    index_document = "index.html"
  }

  force_destroy = true  # Optional: allows auto-deleting all objects if you destroy the bucket
}

# Set object ownership to BucketOwnerEnforced
resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.s3Bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# Disable S3 block public access
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.s3Bucket.id

  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}

# Attach a public-read policy using a separate resource
resource "aws_s3_bucket_policy" "public_policy" {
  bucket = aws_s3_bucket.s3Bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "arn:aws:s3:::my-terraform-with-cicd/*"
      }
    ]
  })
}
