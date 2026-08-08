output "bucket_name" {
  description = "Nome do bucket S3 do CloudTrail"
  value       = var.enabled ? aws_s3_bucket.cloudtrail[0].id : ""
}

output "trail_arn" {
  description = "ARN do CloudTrail"
  value       = var.enabled ? aws_cloudtrail.main[0].arn : ""
}
