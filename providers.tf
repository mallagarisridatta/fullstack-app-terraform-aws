provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "FullstackApp"
      Environment = var.environment
      ManagedBy   = "Terraform"
      Owner       = "CloudArchitectureTeam"
    }
  }
}