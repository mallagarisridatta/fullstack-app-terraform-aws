resource "aws_kms_key" "main" {
  description             = "KMS key for enterprise infrastructure encryption"
  deletion_window_in_days = 30
  enable_key_rotation     = true
  policy                  = var.policy

  tags = var.tags
}

resource "aws_kms_alias" "main" {
  name          = "alias/${var.environment}-main-key"
  target_key_id = aws_kms_key.main.key_id
}