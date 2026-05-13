module "kms" {
  source       = "./modules/kms"
  project_name = var.project_name
  environment  = var.environment
}

module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr           = var.vpc_cidr
  project_name       = var.project_name
  environment        = var.environment
  log_bucket_arn     = module.s3_logs.bucket_arn
}

module "s3_logs" {
  source       = "./modules/s3"
  bucket_name  = "${var.project_name}-${var.environment}-logs-${data.aws_caller_identity.current.account_id}"
  kms_key_arn  = module.kms.key_arn
  environment  = var.environment
}

data "aws_caller_identity" "current" {}