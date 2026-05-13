# Enterprise AWS Infrastructure (IaC)

## Overview
This repository contains production-ready Terraform code to deploy a secure, scalable AWS environment for a full-stack application. 

### Architecture Components
- **VPC**: Single AZ setup with 1 Public and 1 Private subnet (as requested), including NAT Gateway for private egress.
- **S3 Logging**: Centralized logging bucket with MFA Delete, Versioning, and KMS Encryption.
- **Security**: KMS Customer Managed Key (CMK) for encryption at rest; IAM roles following least privilege.
- **CI/CD**: Support for Harness, Jenkins, and AWS CodePipeline.

## Prerequisites
- Terraform >= 1.5.0
- AWS CLI configured with appropriate permissions.
- MFA enabled on the root account (required for MFA Delete configuration).

## Usage
1. Navigate to `terraform/environments/prod`.
2. Run `terraform init`.
3. Run `terraform plan` to review changes.
4. Run `terraform apply` to deploy.

*Note: Enabling MFA Delete via Terraform requires the `mfa` argument in the provider or manual CLI intervention as it requires a physical MFA token code during the API call.*