resource "aws_guardduty_detector" "main" {
  count = var.enabled ? 1 : 0

  enable = true

  datasources {
    s3_logs {
      enable = true
    }
    kubernetes {
      audit_logs {
        enable = false
      }
    }
    malware_protection {
      scan_ec2_instance_with_findings {
        ebs_volumes {
          enable = true
        }
      }
    }
  }

  tags = var.tags
}

resource "aws_sns_topic" "guardduty_alerts" {
  count = var.enabled ? 1 : 0

  name = "guardduty-critical-alerts"
  tags = var.tags
}

resource "aws_sns_topic_subscription" "guardduty_email" {
  count = var.enabled ? 1 : 0

  topic_arn = aws_sns_topic.guardduty_alerts[0].arn
  protocol  = "email"
  endpoint  = var.alert_email
}

resource "aws_cloudwatch_event_rule" "guardduty_findings" {
  count = var.enabled ? 1 : 0

  name        = "guardduty-high-severity-findings"
  description = "Captura findings do GuardDuty com severidade >= 7 (High/Critical)"

  event_pattern = jsonencode({
    source      = ["aws.guardduty"]
    detail-type = ["GuardDuty Finding"]
    detail = {
      severity = [{ numeric = [">=", 7] }]
    }
  })

  tags = var.tags
}

resource "aws_cloudwatch_event_target" "guardduty_sns" {
  count = var.enabled ? 1 : 0

  rule      = aws_cloudwatch_event_rule.guardduty_findings[0].name
  target_id = "SendToSNS"
  arn       = aws_sns_topic.guardduty_alerts[0].arn

  input_transformer {
    input_paths = {
      severity    = "$.detail.severity"
      type        = "$.detail.type"
      description = "$.detail.description"
      account     = "$.detail.accountId"
      region      = "$.region"
    }
    input_template = "\"[GuardDuty ALERT] Severidade: <severity> | Tipo: <type> | Conta: <account> | Região: <region> | Descrição: <description>\""
  }
}

resource "aws_sns_topic_policy" "guardduty_alerts" {
  count = var.enabled ? 1 : 0

  arn = aws_sns_topic.guardduty_alerts[0].arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid    = "AllowEventBridgePublish"
      Effect = "Allow"
      Principal = {
        Service = "events.amazonaws.com"
      }
      Action   = "sns:Publish"
      Resource = aws_sns_topic.guardduty_alerts[0].arn
    }]
  })
}
