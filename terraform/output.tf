output "web_url" {
  value = values(aws_s3_bucket.bucket)[*].bucket_regional_domain_name
}