resource "aws_backup_vault" "dr-backup-vault" {
  name          = "dr-backup-vault"
  force_destroy = true
  kms_key_arn   = aws_kms_key.dr-backup-key.arn

  tags = {
    Name = "dr-backup-vault"
  }
}

resource "aws_kms_key" "dr-backup-key" {
  description             = "KMS key for DR backup"
  is_enabled              = true
  key_usage               = "ENCRYPT_DECRYPT"
  deletion_window_in_days = 30
  enable_key_rotation     = true
}

resource "aws_backup_plan" "dr-backup-plan" {
  name = "dr-backup-plan"

  rule {
    rule_name         = "dr-backup-rule"
    target_vault_name = aws_backup_vault.dr-backup-vault.name
    schedule          = "cron(0 12 * * ? *)"

    lifecycle {
      delete_after = 30
    }

    copy_action {
      destination_vault_arn = aws_backup_vault.dr-backup-vault.arn
      lifecycle {
        delete_after = 30
      }
    }
  }

}

resource "aws_backup_selection" "dr-backup-selection" {
  name         = "dr-backup-selection"
  iam_role_arn = var.dr-backup-role-arn
  plan_id      = aws_backup_plan.dr-backup-plan.id
  selection_tag {
    type  = "STRINGEQUALS"
    key   = "Backup"
    value = "true"
  }
}

# resource "aws_backup_plan" "backup_copy_plan" {
#   name = "cross-region-backup"

#   rule {
#     rule_name         = "replicate-backup"
#     target_vault_name = aws_backup_vault.dr-backup-vault.name
#     copy_action {
#       destination_vault_arn = aws_backup_vault.dr-backup-vault.arn
#     }
#   }
# }
