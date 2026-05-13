module "kms" {
  source = "./modules/kms"
  environment = var.environment
}

module "storage" {
  source            = "./modules/storage"
  environment       = var.environment
  kms_key_arn       = module.kms.key_arn
  mfa_delete_status = var.mfa_delete_status
}

module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr           = var.vpc_cidr
  environment        = var.environment
  log_bucket_arn     = module.storage.log_bucket_arn
  kms_key_arn        = module.kms.key_arn
}

module "database" {
  source          = "./modules/database"
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  kms_key_arn     = module.kms.key_arn
  environment     = var.environment
}

module "compute" {
  source          = "./modules/compute"
  vpc_id          = module.vpc.vpc_id
  public_subnets  = module.vpc.public_subnets
  private_subnets = module.vpc.private_subnets
  environment     = var.environment
  # Application specific analysis: Node.js backend requires ARM64 for Graviton optimization
  cpu_architecture = "ARM64"
}