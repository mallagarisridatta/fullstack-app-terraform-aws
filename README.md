# Fullstack App Infrastructure

This repository contains the enterprise-grade IaC for a full-stack application.

## Architecture
- **VPC**: Custom VPC with 1 Public Subnet (NAT Gateway) and 1 Private Subnet.
- **S3**: Secure logging bucket with KMS encryption, Versioning, and MFA Delete enabled.
- **CI/CD**: Support for Jenkins, AWS CodePipeline, and Harness.

## Prerequisites
- Terraform 1.5.7+
- AWS CLI configured with appropriate permissions.
- MFA Token (required for modifying S3 MFA Delete settings).

## Deployment
1. Navigate to `terraform/environments/prod`.
2. Run `terraform init`.
3. Run `terraform apply`.