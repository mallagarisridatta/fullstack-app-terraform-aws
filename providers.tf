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
    organization = "your-org-name"
    workspaces {
      name = "fullstack-app-prod"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Project     = "FullStackApp"
      ManagedBy   = "Terraform"
    }
  }
}