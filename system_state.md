# Current System State Summary

## Networking (VPC)
- **VPC ID**: `aws_vpc.main` (CIDR: `10.0.0.0/16`)
- **Subnets**:
  - `Public Subnet`: `10.0.1.0/24` (Route to IGW via `aws_internet_gateway.igw`)
  - `Private Subnet`: `10.0.10.0/24` (Route to NAT Gateway via `aws_nat_gateway.nat`)
- **Flow Logs**: Enabled, destination S3 bucket `module.s3_logs.bucket_id`.

## Storage & Security
- **Log Bucket**: `prod-enterprise-logs-${account_id}`
  - **Versioning**: Enabled
  - **MFA Delete**: Enabled (Requires MFA token for deletion/versioning changes)
  - **Encryption**: SSE-KMS using Customer Managed Key (CMK)
  - **Public Access**: Blocked (All 4 settings enabled)
- **KMS Key**: Customer Managed Key with automatic rotation enabled.

## Compute & Database
- **ECS Cluster**: `enterprise-app-cluster` (Fargate)
- **Database**: Aurora Serverless v2 (PostgreSQL) in private subnets, encrypted with KMS.

## CI/CD
- **Jenkins**: Pipeline defined in `cicd/jenkins/Jenkinsfile`.
- **AWS CodePipeline**: Definition in `cicd/codepipeline/pipeline-definition.json`.
- **Harness**: Configuration in `.harness/pipeline.yaml`.