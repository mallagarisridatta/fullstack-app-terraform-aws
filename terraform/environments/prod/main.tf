provider "aws" {
  region = "us-east-1"
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

module "vpc" {
  source              = "../../modules/vpc"
  project_name        = "fullstack-app"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  az                  = "us-east-1a"
  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}

module "s3_logs" {
  source       = "../../modules/s3"
  project_name = "fullstack-app"
  environment  = "prod"
  tags = {
    Environment = "Production"
    Category    = "Logging"
  }
}