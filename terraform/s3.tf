resource "aws_s3_bucket" "bucket" {
  bucket = "se-dev-demo-bucket"

}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"

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