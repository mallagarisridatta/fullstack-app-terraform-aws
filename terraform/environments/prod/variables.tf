variable "region" {
  default = "us-east-1"
}

variable "tags" {
  type = map(string)
  default = {
    Project     = "EnterpriseStack"
    Environment = "Prod"
    ManagedBy   = "Terraform"
  }
}