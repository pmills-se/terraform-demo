resource "aws_s3_bucket" "bucket" {
  bucket = "demo-bucket-${random_string.this.result}"

}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"

}

resource "random_string" "this" {
  length = 4
  special = false
  upper = false
}