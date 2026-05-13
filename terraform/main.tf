terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  # Remote backend configuration for Terraform Enterprise/Cloud
  backend "remote" {
    organization = "enterprise-org"
    workspaces {
      name = "fullstack-app-prod"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = "Production"
      Project     = "FullstackApp"
      ManagedBy   = "Terraform"
    }
  }
}

data "aws_caller_identity" "current" {}

module "kms" {
  source = "./modules/kms"
}

module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr           = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.10.0/24"
  log_bucket_id      = module.s3_logs.bucket_id
}

module "s3_logs" {
  source      = "./modules/s3"
  bucket_name = "prod-enterprise-logs-${data.aws_caller_identity.current.account_id}"
  kms_key_arn = module.kms.key_arn
}

module "rds" {
  source             = "./modules/rds"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = [module.vpc.private_subnet_id]
  kms_key_arn        = module.kms.key_arn
  db_name            = "appdb"
}

module "ecs" {
  source              = "./modules/ecs"
  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = [module.vpc.public_subnet_id]
  private_subnet_ids  = [module.vpc.private_subnet_id]
  kms_key_arn         = module.kms.key_arn
  db_endpoint         = module.rds.db_endpoint
  container_insights  = true
}