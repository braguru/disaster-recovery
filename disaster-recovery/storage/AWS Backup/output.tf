output "dr-backup-vault-name" {
  value = aws_backup_vault.dr-backup-vault.name
}

output "dr-backup-plan-name" {
  value = aws_backup_plan.dr-backup-plan.name
}

output "dr-backup-selection-name" {
  value = aws_backup_selection.dr-backup-selection.name
}

output "dr-backup-plan-id" {
  value = aws_backup_plan.dr-backup-plan.id
}

output "dr-backup-vault-arn" {
  value = aws_backup_vault.dr-backup-vault.arn
}

output "dr-backup-key-arn" {
  value = aws_kms_key.dr-backup-key.arn
}

output "dr-backup-plan-arn" {
  value = aws_backup_plan.dr-backup-plan.arn
}

output "dr-backup-selection-arn" {
  value = aws_backup_selection.dr-backup-selection.id
}

