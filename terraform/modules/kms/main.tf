resource "aws_kms_key" "main" {
  description             = "Main encryption key for enterprise resources"
  deletion_window_in_days = 30
  enable_key_rotation     = true
}

resource "aws_kms_alias" "main" {
  name          = "alias/enterprise-key"
  target_key_id = aws_kms_key.main.key_id
}

output "key_arn" {
  value = aws_kms_key.main.arn
}