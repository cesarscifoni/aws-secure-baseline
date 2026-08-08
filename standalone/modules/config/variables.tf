variable "account_name" {
  description = "Nome da conta AWS"
  type        = string
}

variable "enabled" {
  description = "Habilita ou desabilita a criação dos recursos"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags padrão"
  type        = map(string)
  default     = {}
}
