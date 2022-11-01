resource "aws_s3_bucket" "bucket" {
  bucket = "se-dev-demo-bucket"

}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.bucket
  acl    = "private"

}