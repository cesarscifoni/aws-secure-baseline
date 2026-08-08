data "aws_caller_identity" "current" {}

locals {
  allowed_regions = [
    "us-east-1",
    "us-east-2",
  ]
}

resource "aws_iam_policy" "region_lockdown" {
  count = var.enabled ? 1 : 0

  name        = "RegionLockdown"
  description = "Nega acesso a todas as regiões exceto as permitidas"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "DenyAllOutsideAllowedRegions"
        Effect = "Deny"
        NotAction = [
          "iam:*",
          "sts:*",
          "route53:*",
          "cloudfront:*",
          "waf:*",
          "budgets:*",
          "account:*",
          "organizations:*",
          "support:*",
          "trustedadvisor:*",
          "health:*",
        ]
        Resource = "*"
        Condition = {
          StringNotEquals = {
            "aws:RequestedRegion" = local.allowed_regions
          }
        }
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_group" "region_restricted" {
  count = var.enabled ? 1 : 0

  name = "RegionRestrictedUsers"
}

resource "aws_iam_group_policy_attachment" "region_lockdown" {
  count = var.enabled ? 1 : 0

  group      = aws_iam_group.region_restricted[0].name
  policy_arn = aws_iam_policy.region_lockdown[0].arn
}
