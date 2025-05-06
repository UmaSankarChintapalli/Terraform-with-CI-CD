provider "aws" {
  region = "us-east-1"
}

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

  depends_on = [
    aws_s3_bucket_public_access_block.public_access
  ]
}
