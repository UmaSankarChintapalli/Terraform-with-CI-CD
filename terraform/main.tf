provider "aws" {
  region = "us-east-1"
}
resource "aws_s3_bucket" "s3Bucket" {
  bucket = "s3-demo-terraform-cicd"

  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.s3Bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.s3Bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "MakePublic",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.s3Bucket.arn}/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.public_access]
}

