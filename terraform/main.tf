provider "aws" {
  region = var.aws_region
}

terraform {
  backend "remote" {
    # Configuration for Terraform Enterprise / Cloud
    organization = "enterprise-org"
    workspaces {
      name = "fullstack-app-prod"
    }
  }
}

module "kms" {
  source = "./modules/kms"
}

module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr           = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.10.0/24"
  kms_key_arn        = module.kms.key_arn
}

module "s3_logs" {
  source      = "./modules/s3"
  bucket_name = "prod-enterprise-logs-${data.aws_caller_identity.current.account_id}"
  kms_key_arn = module.kms.key_arn
}

data "aws_caller_identity" "current" {}