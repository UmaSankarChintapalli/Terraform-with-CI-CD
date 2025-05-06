resource "aws_s3_bucket" "s3Bucket" {
  bucket = "my-terraform-with-cicd"

  # Bucket policy to allow public read access to all objects
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::my-terraform-with-cicd/*"
    }
  ]
}
EOF

  # Static website configuration
  website {
    index_document = "index.html"
    # Optional: Set an error document if desired
    # error_document = "error.html"
  }
}
