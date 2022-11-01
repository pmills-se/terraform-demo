output "web_url" {
  value = [for bucket in aws_s3_bucket.bucket : bucket.bucket_domain_name]
  # value = aws_s3_bucket.bucket.bu
}