resource "aws_s3_bucket" "s3_bucket" {
  count                       = var.s3_should_be_created ? 1 : 0

  bucket                      = var.s3_bucket_name

  # Prevent accidental deletion of this S3 bucket
  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name  = var.s3_bucket_name
  }
}

# Enable versioning so you can see the full revision history of your
# state files
resource "aws_s3_bucket_versioning" "enabled" {
  #bucket = aws_s3_bucket.s3_bucket.id
  bucket = concat(aws_s3_bucket.s3_bucket.*.id, [""])[0]
  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption by default
resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  # bucket = aws_s3_bucket.s3_bucket.id
  bucket = concat(aws_s3_bucket.s3_bucket.*.id, [""])[0]

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Explicitly block all public access to the S3 bucket
resource "aws_s3_bucket_public_access_block" "public_access" {
  #bucket                  = aws_s3_bucket.s3_bucket.id
  bucket                  = concat(aws_s3_bucket.s3_bucket.*.id, [""])[0]
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

/* resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  #bucket                      = aws_s3_bucket.s3_bucket.id
  bucket                      = concat(aws_s3_bucket.s3_bucket.*.id, [""])[0]
  acl                         = "private" 
} */