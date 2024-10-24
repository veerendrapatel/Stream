provider "aws" {
  region  = var.region
  profile = var.aws_profile
}
# Fetching current AWS caller identity details
data "aws_caller_identity" "current" {}