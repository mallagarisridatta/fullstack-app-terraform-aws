resource "aws_s3_bucket" "logs" {
  bucket        = var.bucket_name
  force_destroy = false # Prevent accidental deletion of logs

  tags = {
    Name = var.bucket_name
  }
}

# MFA Delete and Versioning
# Note: To fully enable MFA Delete, you must use the AWS CLI with MFA credentials.
resource "aws_s3_bucket_versioning" "logs_versioning" {
  bucket = aws_s3_bucket.logs.id
  versioning_configuration {
    status     = "Enabled"
    mfa_delete = "Enabled"
  }
}

# Encryption at Rest using KMS
resource "aws_s3_bucket_server_side_encryption_configuration" "logs_encryption" {
  bucket = aws_s3_bucket.logs.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.kms_key_arn
      sse_algorithm     = "aws:kms"
    }
    bucket_key_enabled = true
  }
}

# Block Public Access (CIS Benchmark)
resource "aws_s3_bucket_public_access_block" "logs_access" {
  bucket = aws_s3_bucket.logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Lifecycle policy to transition logs to cheaper storage
resource "aws_s3_bucket_lifecycle_configuration" "logs_lifecycle" {
  bucket = aws_s3_bucket.logs.id

  rule {
    id     = "log-retention"
    status = "Enabled"

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    expiration {
      days = 90
    }
  }
}