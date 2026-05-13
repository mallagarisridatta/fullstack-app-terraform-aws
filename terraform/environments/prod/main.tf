provider "aws" {
  region = var.region
}

data "aws_caller_identity" "current" {}

module "kms" {
  source      = "../../modules/kms"
  environment = "prod"
  tags        = var.tags
  policy      = data.aws_iam_policy_document.kms_policy.json
}

module "s3_logs" {
  source      = "../../modules/s3"
  environment = "prod"
  account_id  = data.aws_caller_identity.current.account_id
  kms_key_arn = module.kms.key_arn
  tags        = var.tags
}

module "vpc" {
  source               = "../../modules/vpc"
  environment          = "prod"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidr   = "10.0.1.0/24"
  private_subnet_cidr  = "10.0.10.0/24"
  az                   = "${var.region}a"
  log_bucket_arn       = module.s3_logs.bucket_arn
  flow_log_role_arn    = aws_iam_role.vpc_flow_log_role.arn
  tags                 = var.tags
}

# IAM Role for VPC Flow Logs
resource "aws_iam_role" "vpc_flow_log_role" {
  name = "vpc-flow-log-role-prod"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        }
      },
    ]
  })
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
}