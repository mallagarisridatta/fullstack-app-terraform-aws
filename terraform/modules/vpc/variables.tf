variable "vpc_cidr" { type = string }
variable "public_subnet_cidr" { type = string }
variable "private_subnet_cidr" { type = string }
variable "az" { type = string }
variable "environment" { type = string }
variable "tags" { type = map(string) }
variable "log_bucket_arn" { type = string }
variable "flow_log_role_arn" { type = string }