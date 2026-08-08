output "budget_name" {
  description = "Nome do budget criado"
  value       = var.enabled ? aws_budgets_budget.monthly[0].name : ""
}
