terraform {
  backend "s3" {
    bucket                 = "[bucket_name]"
    key                    = "location_terraform_state"
    region                 = "ap-southeast-3"
    skip_region_validation = true
    dynamodb_table         = "dynamodb_table_name"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.61.0"
    }
  }
}

provider "aws" {
  region = var.region
}