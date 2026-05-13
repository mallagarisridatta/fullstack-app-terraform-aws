# Enterprise AWS Foundation - VPC & Secure Logging

This Terraform configuration establishes a production-ready networking foundation and a secure, encrypted S3 bucket for logging, adhering to the AWS Well-Architected Framework and CIS benchmarks.

## Architecture Overview
- **VPC**: A custom VPC with a public and private subnet architecture across multiple Availability Zones (optimized for high availability).
- **S3 Logging Bucket**: A hardened S3 bucket with:
    - AES-256 Encryption via AWS KMS (CMK).
    - MFA Delete enabled (requires manual CLI activation with MFA token).
    - Versioning enabled.
    - Public Access Blocked.
- **Security**: VPC Flow Logs are enabled and directed to the S3 bucket.
- **KMS**: Customer Managed Key (CMK) for data-at-rest encryption.

## Prerequisites
- Terraform Cloud/Enterprise account for the remote backend.
- AWS CLI configured with administrative permissions.
- A physical or virtual MFA device (required to enable MFA Delete on S3).

## Usage
1. Update `terraform.tf` with your Terraform Enterprise organization and workspace names.
2. Initialize: `terraform init`.
3. Plan: `terraform plan`.
4. Apply: `terraform apply`.

**Note on MFA Delete**: Terraform can set the state to `Enabled`, but AWS requires a root/IAM user with MFA to perform the actual API call with a serial number and code to toggle this setting. See `modules/s3/main.tf` for details.