provider "aws" {
region = "us-east-1"
}

resource "aws_s3_bucket" "s3Bucket" {
     bucket = "my-terraform-with-cicd"
     acl       = "public-read"

     policy  = <<EOF
{
     "id" : "MakePublic",
   "version" : "2012-10-17",
   "statement" : [
      {
         "action" : [
             "s3:GetObject"
          ],
         "effect" : "Allow",
         "resource" : "arn:aws:s3:::my-terraform-with-cicd/*",
         "principal" : "*"
      }
    ]
  }
EOF

   website {
       index_document = "index.html"
   }
}