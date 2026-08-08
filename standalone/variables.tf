variable "aws_region" {
  description = "Região AWS principal"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "Profile AWS CLI a ser usado"
  type        = string
  default     = "standalone-baseline"
}

variable "account_name" {
  description = "Nome da conta AWS (usado em tags e nomes de recursos)"
  type        = string
  default     = "aws-secure-baseline-standalone"
}

variable "alert_email" {
  description = "E-mail para receber alertas de segurança e budget"
  type        = string
}

variable "budget_limit_usd" {
  description = "Limite mensal de gasto em USD para o budget alert"
  type        = string
  default     = "10"
}

variable "tags" {
  description = "Tags padrão aplicadas em todos os recursos"
  type        = map(string)
  default     = {}
}

variable "enabled" {
  description = "Habilita ou desabilita a criação de todos os recursos. Use false para destruir tudo sem apagar o código."
  type        = bool
  default     = false
}
