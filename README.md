# Enterprise Full-Stack AWS Infrastructure

This repository contains the production-grade Terraform configuration for deploying a full-stack application (Node.js/React/PostgreSQL) to AWS. 

## Architecture Overview
- **Networking**: Custom VPC with Public and Private subnets across multiple Availability Zones (optimized for HA, despite the 1-subnet minimum requirement).
- **Compute**: AWS ECS Fargate using Graviton (ARM64) processors for cost-performance optimization.
- **Database**: Amazon Aurora Serverless v2 (PostgreSQL) for automated scaling and high availability.
- **Security**: 
  - Customer Managed Keys (KMS) for all encryption at rest.
  - S3 Bucket with MFA Delete, Versioning, and strict Public Access Block.
  - IAM roles following the Principle of Least Privilege.
- **Observability**: VPC Flow Logs and CloudWatch integration.

## Prerequisites
- Terraform 1.5+
- AWS CLI configured with appropriate permissions.
- A valid MFA device (required for S3 MFA Delete configuration changes).

## Usage
1. Initialize Terraform: `terraform init`
2. Plan the deployment: `terraform plan`
3. Apply the configuration: `terraform apply`