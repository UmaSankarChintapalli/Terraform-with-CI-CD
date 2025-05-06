provider "aws" {
region = "us-east-1"
}

resource "aws_s3_bucket" "s3Bucket" {
     bucket = "s3-demo-terraform-cicd"
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
         "resource" : "arn:aws:s3:::s3-demo-terraform-cicd/*",
         "principal" : "*"
      }
    ]
  }
EOF

   website {
       index_document = "index.html"
   }
}