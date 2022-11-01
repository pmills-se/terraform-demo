resource "aws_s3_bucket" "bucket" {
  for_each = var.bucket_names
  bucket   = "se-dev-demo-bucket-${each.value}"

}

resource "aws_s3_bucket_acl" "bucket_acl" {
  for_each = aws_s3_bucket.bucket
  bucket   = each.value.id
  acl      = "public-read"

}

resource "aws_s3_object" "index" {
  for_each     = aws_s3_bucket.bucket
  bucket       = each.value.id
  key          = "index.html"
  source       = "${path.module}/index.html"
  content_type = "text/html"

}

resource "aws_s3_bucket_website_configuration" "bucket_website" {
  for_each = aws_s3_bucket.bucket
  bucket   = each.value.id

  index_document {
    suffix = "index.html"
  }

}

resource "aws_s3_bucket_cors_configuration" "bucket_cors" {
  for_each = aws_s3_bucket.bucket
  bucket   = each.value.id

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
  }

}

resource "aws_s3_bucket_policy" "public_access" {
  for_each = aws_s3_bucket.bucket
  bucket   = each.value.id
  policy   = <<EOF
    {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::${each.value.id}/*"
            ]
        }
    ]
}
EOF
}
