# Current System State Summary

## Networking (VPC)
- **VPC ID**: `aws_vpc.main` (CIDR: `10.0.0.0/16`)
- **Subnets**:
  - `Public Subnet`: `10.0.1.0/24` (Route to IGW)
  - `Private Subnet`: `10.0.10.0/24` (Route to NAT Gateway)
- **Flow Logs**: Enabled, destination S3 bucket.

## Storage & Security
- **Log Bucket**: `prod-enterprise-logs-<account_id>`
  - **Versioning**: Enabled
  - **MFA Delete**: Enabled
  - **Encryption**: KMS (SSE-KMS) using CMK
  - **Public Access**: Blocked (All 4 settings)
- **KMS Key**: Customer Managed Key with automatic rotation enabled.

## CI/CD
- **Jenkins**: Pipeline defined in `cicd/jenkins/Jenkinsfile`.
- **AWS CodePipeline**: Definition in `cicd/codepipeline/pipeline-definition.json`.
- **Harness**: Configuration in `.harness/pipeline.yaml`.