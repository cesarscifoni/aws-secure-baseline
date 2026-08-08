locals {
  default_tags = merge(
    {
      Project     = "aws-secure-baseline"
      Environment = "standalone"
      ManagedBy   = "terraform"
    },
    var.tags
  )
}

module "cloudtrail" {
  source       = "./modules/cloudtrail"
  account_name = var.account_name
  tags         = local.default_tags
  enabled      = var.enabled
}

module "config" {
  source       = "./modules/config"
  account_name = var.account_name
  tags         = local.default_tags
  enabled      = var.enabled

  depends_on = [module.cloudtrail]
}

module "guardduty" {
  source      = "./modules/guardduty"
  alert_email = var.alert_email
  tags        = local.default_tags
  enabled     = var.enabled
}

module "securityhub" {
  source  = "./modules/securityhub"
  tags    = local.default_tags
  enabled = var.enabled

  depends_on = [module.config]
}

module "iam_baseline" {
  source  = "./modules/iam-baseline"
  tags    = local.default_tags
  enabled = var.enabled
}

module "budget_alerts" {
  source           = "./modules/budget-alerts"
  alert_email      = var.alert_email
  budget_limit_usd = var.budget_limit_usd
  enabled          = var.enabled
}

module "region_lockdown" {
  source       = "./modules/region-lockdown"
  account_name = var.account_name
  tags         = local.default_tags
  enabled      = var.enabled
}
