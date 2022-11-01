module "s3-website" {
  source = "../../"

  bucket_names = [
    "red",
    "blue",
    "green"
  ]
}