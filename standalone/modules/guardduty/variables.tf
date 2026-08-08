variable "alert_email" {
  description = "E-mail para receber alertas de findings críticos"
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
