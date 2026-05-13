# Enterprise Fullstack AWS Infrastructure

This repository contains the production-ready IaC for a fullstack application using AWS, Terraform, and CI/CD pipelines.

## Architecture Overview
- **VPC**: 1 Public Subnet (IGW), 1 Private Subnet (NAT Gateway).
- **Compute**: ECS Fargate (Graviton-ready) for Frontend and Backend.
- **Database**: Aurora Serverless v2 (PostgreSQL).
- **Security**: KMS CMK for S3 and RDS encryption. S3 Log bucket with MFA Delete enabled.
- **CI/CD**: Support for Jenkins, AWS CodePipeline, and Harness.

## Prerequisites
- Terraform 1.5+
- AWS CLI configured with appropriate permissions.
- MFA token (required for S3 MFA Delete configuration changes).

## Deployment
1. Initialize Terraform: `terraform init`
2. Plan: `terraform plan`
3. Apply: `terraform apply` (Note: MFA token required for S3 bucket changes).