output "detector_id" {
  description = "ID do detector do GuardDuty"
  value       = var.enabled ? aws_guardduty_detector.main[0].id : ""
}

output "sns_topic_arn" {
  description = "ARN do SNS topic de alertas"
  value       = var.enabled ? aws_sns_topic.guardduty_alerts[0].arn : ""
}
