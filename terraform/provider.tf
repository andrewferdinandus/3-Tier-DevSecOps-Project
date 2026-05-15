terraform {
  required_version = ">= 1.10.0"

  # BEST PRACTICE: Remote State Storage
  backend "s3" {
    bucket       = "3tier-state-file-store"
    key          = "state/terraform.tfstate" # You can change the path/name as needed
    region       = "ap-southeast-2"

    # This is the crucial line for Terraform 1.10+
    # It uses the Object Lock capabilities you just enabled
    use_lockfile = true 
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}