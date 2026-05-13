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
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

module "kms" {
  source = "../../modules/kms"
  alias  = "alias/s3-logs-key"
}

module "vpc" {
  source               = "../../modules/vpc"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidr   = "10.0.1.0/24"
  private_subnet_cidr  = "10.0.2.0/24"
  availability_zone    = "${var.aws_region}a"
  environment          = "prod"
}

module "s3_logs" {
  source      = "../../modules/s3"
  bucket_name = "enterprise-app-logs-${var.aws_region}-${var.account_id}"
  kms_key_arn = module.kms.key_arn
  environment = "prod"
}