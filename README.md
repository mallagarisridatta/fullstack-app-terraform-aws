# Fullstack App Infrastructure

This repository contains the enterprise-grade IaC for a fullstack application using AWS and Terraform.

## Architecture
- **VPC**: 1 Public Subnet (with IGW), 1 Private Subnet (with NAT Gateway).
- **S3**: Log bucket with MFA Delete enabled, Versioning, and KMS Encryption.
- **Security**: KMS Customer Managed Key for encryption at rest.
- **CI/CD**: Support for Jenkins, AWS CodePipeline, and Harness.

## Prerequisites
- Terraform 1.5+
- AWS CLI configured with appropriate permissions.
- **MFA Delete Note**: To enable MFA Delete, you must perform the initial `terraform apply` using credentials that include an MFA token. Terraform cannot manage the MFA token itself.

## Deployment
1. Navigate to `terraform/environments/prod`.
2. Run `terraform init`.
3. Run `terraform apply`.

## Variables
- `aws_region`: The AWS region to deploy into.
- `account_id`: Your AWS Account ID for resource naming uniqueness.