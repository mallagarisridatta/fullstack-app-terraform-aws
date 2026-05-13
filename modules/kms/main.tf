resource "aws_kms_key" "main" {
  description             = "Primary CMK for FullStack App Encryption"
  deletion_window_in_days = 30
  enable_key_rotation     = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }
        Action   = "kms:*"
        Resource = "*"
      }
    ]
  })
}

resource "aws_kms_alias" "main" {
  name          = "alias/fullstack-app-${var.environment}"
  target_key_id = aws_kms_key.main.key_id
}

output "key_arn" {
  value = aws_kms_key.main.arn
}