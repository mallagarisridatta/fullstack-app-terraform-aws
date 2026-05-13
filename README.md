# Enterprise Fullstack AWS Infrastructure

This repository contains the production-ready Terraform configuration for deploying a fullstack application (Node.js/React) to AWS, following the Well-Architected Framework.

## Architecture Overview
- **VPC**: Multi-tier networking with public and private subnets.
- **Security**: KMS CMK for data-at-rest encryption, IAM roles with least privilege, and S3 MFA Delete.
- **Compute**: ECS Fargate (Serverless) for the backend API.
- **Database**: RDS Aurora Serverless v2 for scalable, cost-effective data storage.
- **Logging**: Centralized S3 bucket for VPC Flow Logs and application logs.

## Prerequisites
1. **Terraform CLI**: v1.5+
2. **AWS CLI**: Configured with appropriate credentials.
3. **MFA**: To enable MFA Delete, you must use the AWS CLI with root credentials to set the versioning state, as Terraform cannot pass the MFA token directly in the HCL.

## Deployment
```bash
terraform init
terraform plan
terraform apply
```

## Security Features
- **Encryption**: All data at rest is encrypted using a Customer Managed Key (KMS).
- **Network Isolation**: The database and backend tasks reside in private subnets with no direct internet access.
- **MFA Delete**: Prevents accidental or malicious deletion of critical log data.