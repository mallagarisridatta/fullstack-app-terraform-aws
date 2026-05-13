# Current System State Summary

## Infrastructure Components

### Networking
- **VPC**: `main-vpc` (10.0.0.0/16)
- **Public Subnet**: `public-subnet-01` (10.0.1.0/24) in AZ-a. Includes Internet Gateway and Route Table.
- **Private Subnet**: `private-subnet-01` (10.0.2.0/24) in AZ-a. Includes NAT Gateway for outbound traffic.

### Storage & Security
- **S3 Log Bucket**: `enterprise-app-logs-<region>-<account_id>`
  - **Versioning**: Enabled
  - **MFA Delete**: Enabled
  - **Encryption**: AWS KMS (SSE-KMS) using a Customer Managed Key.
  - **Public Access**: Blocked (All 4 settings).
- **KMS Key**: Dedicated key for S3 log encryption with rotation enabled.

### CI/CD Pipelines
- **Jenkins**: Configured for multi-stage deployment with manual approval.
- **AWS CodePipeline**: Source-to-Build mapping defined.
- **Harness**: Pipeline YAML provided for infrastructure and service deployment.