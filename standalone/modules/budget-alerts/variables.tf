variable "alert_email" {
  description = "E-mail para receber alertas de budget"
  type        = string
}

variable "budget_limit_usd" {
  description = "Limite mensal em USD"
  type        = string
  default     = "10"
}

variable "enabled" {
  description = "Habilita ou desabilita a criação dos recursos"
  type        = bool
  default     = true
}
