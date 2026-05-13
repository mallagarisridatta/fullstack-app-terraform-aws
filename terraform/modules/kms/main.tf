resource "aws_kms_key" "main" {
  description             = "KMS key for S3 encryption"
  deletion_window_in_days = 30
  enable_key_rotation     = true
}

resource "aws_kms_alias" "main" {
  name          = var.alias
  target_key_id = aws_kms_key.main.key_id
}

output "key_arn" {
  value = aws_kms_key.main.arn
}