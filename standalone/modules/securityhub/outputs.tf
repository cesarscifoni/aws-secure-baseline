output "hub_arn" {
  description = "ARN do Security Hub"
  value       = var.enabled ? aws_securityhub_account.main[0].id : ""
}
