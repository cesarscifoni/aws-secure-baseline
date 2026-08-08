resource "aws_iam_account_password_policy" "main" {
  count = var.enabled ? 1 : 0

  minimum_password_length        = 14
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = true
  allow_users_to_change_password = true
  max_password_age               = 90
  password_reuse_prevention      = 24
  hard_expiry                    = false
}

resource "aws_s3_account_public_access_block" "main" {
  count = var.enabled ? 1 : 0

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_ebs_encryption_by_default" "main" {
  count = var.enabled ? 1 : 0

  enabled = true
}
