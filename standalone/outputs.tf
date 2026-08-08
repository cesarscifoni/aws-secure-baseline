output "cloudtrail_bucket" {
  description = "Nome do bucket S3 do CloudTrail"
  value       = module.cloudtrail.bucket_name
}

output "config_recorder_name" {
  description = "Nome do AWS Config recorder"
  value       = module.config.recorder_name
}

output "guardduty_detector_id" {
  description = "ID do detector do GuardDuty"
  value       = module.guardduty.detector_id
}

output "securityhub_arn" {
  description = "ARN do Security Hub"
  value       = module.securityhub.hub_arn
}
