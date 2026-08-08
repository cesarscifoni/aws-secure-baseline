output "recorder_name" {
  description = "Nome do Config recorder"
  value       = var.enabled ? aws_config_configuration_recorder.main[0].name : ""
}

output "config_bucket" {
  description = "Nome do bucket S3 do Config"
  value       = var.enabled ? aws_s3_bucket.config[0].id : ""
}
