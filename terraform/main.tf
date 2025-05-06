provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "s3Bucket" {
  bucket = "s3-demo-terraform-cicd"
  acl    = "public-read"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "MakePublic",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::s3-demo-terraform-cicd/*"
    }
  ]
}
EOF

  website {
    index_document = "index.html"
  }
}
