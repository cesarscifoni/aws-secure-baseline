output "password_policy_min_length" {
  description = "Comprimento mínimo da senha configurado"
  value       = var.enabled ? aws_iam_account_password_policy.main[0].minimum_password_length : 0
}
