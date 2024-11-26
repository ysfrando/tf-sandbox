output "bucket_arn" {
  value       = aws_s3_bucket.secure_bucket.arn
  description = "ARN of the created S3 bucket"
}

output "kms_key_arn" {
  value       = aws_kms_key.s3_key.arn
  description = "ARN of the KMS key used for bucket encryption"
}