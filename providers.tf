terraform {
  required_version = "~> 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Assuming Terraform Enterprise/Cloud Workspace
  backend "remote" {
    # organization = "your-org-name"
    # workspaces {
    #   name = "enterprise-stack-prod"
    # }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Project     = "FullstackApp"
      ManagedBy   = "Terraform"
      Owner       = "CloudArchitectureTeam"
    }
  }
}