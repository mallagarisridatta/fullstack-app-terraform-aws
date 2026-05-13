# Enterprise Full-Stack AWS Infrastructure

This repository contains the production-ready Infrastructure as Code (IaC) and CI/CD configurations for a full-stack application. 

## Architecture Overview
- **Networking**: Custom VPC with Public and Private subnets across 1 Availability Zone (expandable to Multi-AZ).
- **Compute**: AWS ECS Fargate running on Graviton2 (ARM64) for cost-optimization.
- **Database**: Amazon RDS Aurora Serverless v2 (PostgreSQL).
- **Security**: 
  - KMS Customer Managed Keys (CMK) for encryption at rest.
  - S3 Log Bucket with MFA Delete and Versioning enabled.
  - IAM roles following the Principle of Least Privilege.
- **CI/CD**: Multi-tool support including Jenkins, AWS CodePipeline, and Harness.

## Prerequisites
- Terraform >= 1.5.0
- AWS CLI configured with appropriate permissions.
- A valid MFA device (required for S3 MFA Delete operations).

## Deployment
1. Initialize Terraform: `terraform init`
2. Plan changes: `terraform plan`
3. Apply: `terraform apply` (Note: Enabling MFA Delete requires MFA headers in the AWS request).