variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "prod"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "mfa_delete_enabled" {
  description = "Whether MFA delete is enabled for the S3 bucket. Note: Requires manual CLI activation with MFA token."
  type        = bool
  default     = true
}