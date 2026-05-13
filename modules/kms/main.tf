resource "aws_kms_key" "s3_key" {
  description             = "KMS key for S3 log encryption"
  deletion_window_in_days = 30
  enable_key_rotation     = true # Security Best Practice

  policy = data.aws_iam_policy_document.kms_policy.json

  tags = {
    Name = "${var.project_name}-s3-kms-key"
  }
}

resource "aws_kms_alias" "s3_key_alias" {
  name          = "alias/${var.project_name}-s3-key"
  target_key_id = aws_kms_key.s3_key.key_id
}

data "aws_iam_policy_document" "kms_policy" {
  statement {
    sid    = "Enable IAM User Permissions"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }

  statement {
    sid    = "Allow VPC Flow Logs to use the key"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
    resources = ["*"]
  }
}

data "aws_caller_identity" "current" {}