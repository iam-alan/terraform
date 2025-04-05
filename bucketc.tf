provider "aws" {
  region = "ap-south-1"  # Specify the AWS region
}

# Create an S3 bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "alan-tf-buck"  # Provide a unique name for the bucket
  acl    = "private"  # You can choose other ACL options like "public-read" or "private"
}

# Optionally, you can add additional configurations to the bucket, such as versioning, lifecycle rules, etc.

