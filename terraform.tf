terraform {
  required_version = "~> 1.5"

  # Remote backend configuration for Terraform Enterprise/Cloud
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "your-org-name"

    workspaces {
      name = "aws-infrastructure-prod"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}