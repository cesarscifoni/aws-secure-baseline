output "policy_arn" {
  description = "ARN da policy de region lockdown"
  value       = var.enabled ? aws_iam_policy.region_lockdown[0].arn : ""
}
