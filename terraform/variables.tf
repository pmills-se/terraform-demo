variable "bucket_names" {
  description = "A list of bucket names to be created"
  type        = set(string)
  default     = [""]

}