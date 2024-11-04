# Update the Terraform configuration to use a local backend

# Terraform 0.13 and later (v1.0)
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.29.0"
    }
  }
  
  backend "s3" {
    bucket = "revlitix-ts-states"
    key = "new-dev/terraform.tfstate"
    region = "us-east-2"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
  profile = "default"
}

# ... rest of your Terraform configuration ...