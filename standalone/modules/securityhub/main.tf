resource "aws_securityhub_account" "main" {
  count = var.enabled ? 1 : 0
}

# Nota: os standards CIS e FSBP ficam em PENDING por vários minutos em contas novas.
# O provider Terraform tem timeout de 3min e falha antes de completar.
# Os standards são habilitados manualmente via CLI após o apply:
#
#   aws securityhub batch-enable-standards \
#     --standards-subscription-requests \
#       StandardsArn=arn:aws:securityhub:::ruleset/cis-aws-foundations-benchmark/v/1.2.0 \
#       StandardsArn=arn:aws:securityhub:us-east-1::standards/aws-foundational-security-best-practices/v/1.0.0 \
#     --profile standalone-baseline --region us-east-1
