resource "aws_s3_bucket" "bucket" {
  bucket = "se-dev-demo-bucket"

}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "public-read"

}

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.bucket.id
  key    = "index.html"
  source = "index.html"

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
terraform {
  backend "s3" {
    bucket         = "sportsengine-dev-terraform-state"
    key            = "terraform-demo/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    profile        = "se-dev"
    dynamodb_table = "terraform-lock"
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "se-dev"
}