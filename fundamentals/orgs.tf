provider "aws" {
  region = "us-east-1"
  alias  = "management"
}

resource "aws_organizations_organization" "main" {
  feature_set = "ALL"

  aws_service_access_principals = [
    "securityhub.amazonaws.com",
    "config.amazonaws.com",
    "cloudtrail.amazonaws.com",
    "guardduty.amazonaws.com"
  ]

  enabled_policy_types = [
    "SERVICE_CONTROL_POLICY",
    "TAG_POLICY"
  ]
}

resource "aws_organizations_organizational_unit" "security" {
  name      = "Security"
  parent_id = aws_organizations_organization.main.roots[0].id
}

resource "aws_organizations_organizational_unit" "workloads" {
  name      = "Workloads"
  parent_id = aws_organizations_organization.main.roots[0].id
}

resource "aws_organizations_policy" "enforce_encryption" {
  name = "enforce-encryption"
  content = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Deny"
        Action = [
          "s3:PutObject"
        ]
        Resource = ["*"]
        Condition = {
          StringNotEquals = {
            "s3:x-amz-server-side-encryption" : ["AES256", "aws:kms"]
          }
        }
      }
    ]
  })
}

resource "aws_securityhub_account" "main" {}

resource "aws_securityhub_organization_admin_account" "main" {
  depends_on       = [aws_securityhub_account.main]
  admin_account_id = aws_securityhub_account.main.id
}

resource "aws_guardduty_detector" "main" {
  enable = true
}
