output "s3_bucket_id" {
  description = "The ID of the S3 bucket"
  #value       = concat(aws_instance.ec2.*.id, [""])[0]
  value       = concat(aws_s3_bucket.s3_bucket.*.id, [""])[0]
}

output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket"
  #value       = aws_s3_bucket.s3_bucket.arn
  value       = concat(aws_s3_bucket.s3_bucket.*.arn, [""])[0]
}