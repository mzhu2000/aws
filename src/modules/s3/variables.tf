variable "s3_should_be_created" {
  description = "Should the S3 be created?"
  type        = bool
  default     = true
}

variable "s3_bucket_name" {
  description = "The Name of the S3 bucket"
  type        = string
  default     = "mzhu2000-s3-terraform-backend"
}