# Current System State Summary

## Networking (VPC)
- **VPC ID**: Managed by Terraform (`aws_vpc.main`)
- **CIDR Block**: `10.0.0.0/16`
- **Subnets**:
  - `Public Subnet 1`: `10.0.1.0/24` (AZ: `us-east-1a`, IGW attached)
  - `Private Subnet 1`: `10.0.10.0/24` (AZ: `us-east-1a`, NAT Gateway access)
- **Flow Logs**: Enabled, streaming to S3 logging bucket.

## Storage & Security (S3 & KMS)
- **Log Bucket**: `enterprise-stack-prod-logs` (Unique suffix applied)
  - **Encryption**: AWS KMS (CMK) with automatic rotation.
  - **Versioning**: Enabled.
  - **MFA Delete**: Enabled.
  - **Public Access**: Fully blocked.
  - **Lifecycle**: 30-day transition to IA, 90-day expiration.
- **KMS Key**: Dedicated Customer Managed Key (CMK) for VPC Flow Logs, S3, and RDS encryption.

## Application Infrastructure
- **Database**: RDS Aurora PostgreSQL (Serverless v2) in private subnets.
- **Compute**: ECS Fargate Cluster running Node.js backend (ARM64/Graviton).
- **Frontend**: React application (S3 + CloudFront distribution).