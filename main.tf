module "kms" {
  source = "./modules/kms"
  environment = var.environment
}

module "s3_logs" {
  source             = "./modules/s3"
  bucket_name        = "enterprise-stack-${var.environment}-logs"
  kms_key_arn        = module.kms.key_arn
  mfa_delete_enabled = var.mfa_delete_enabled
}

module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr           = var.vpc_cidr
  environment        = var.environment
  log_bucket_id      = module.s3_logs.bucket_id
  kms_key_arn        = module.kms.key_arn
}

# Application Layer - Based on analysis of mallagarisridatta/fullstack-app-terraform-aws
# The app requires a Node.js backend and a React frontend.

module "database" {
  source          = "./modules/rds"
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  kms_key_arn     = module.kms.key_arn
  allowed_sg_id   = module.compute.backend_sg_id
}

module "compute" {
  source          = "./modules/ecs"
  vpc_id          = module.vpc.vpc_id
  public_subnets  = module.vpc.public_subnets
  private_subnets = module.vpc.private_subnets
  kms_key_arn     = module.kms.key_arn
  environment     = var.environment
}