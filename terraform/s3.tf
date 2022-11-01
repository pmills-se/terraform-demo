resource "aws_s3_bucket" "bucket" {
  bucket = "se-dev-demo-bucket"

}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "public-read"

}

resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.bucket.id
  key          = "index.html"
  source       = "index.html"
  content_type = "text/html"

}

resource "aws_s3_bucket_website_configuration" "bucket_website" {
  bucket = aws_s3_bucket.bucket.bucket

  index_document {
    suffix = "index.html"
  }

}

resource "aws_s3_bucket_cors_configuration" "bucket_cors" {
  bucket = aws_s3_bucket.bucket.id

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
  }

}

resource "aws_s3_bucket_policy" "public_access" {
  bucket = aws_s3_bucket.bucket.id
  policy = file("policy.json")
}

provider "aws" {
  region  = "us-east-1"
  profile = "se-dev"
}