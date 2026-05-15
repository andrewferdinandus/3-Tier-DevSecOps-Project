terraform {
  required_version = ">= 1.10.0"

  backend "s3" {
    bucket       = "3tier-state-file-store"
    key          = "state/terraform.tfstate"
    region       = "ap-southeast-2"
    use_lockfile = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }

    time = {
      source  = "hashicorp/time"
      version = "~> 0.9"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.0"
    }
  }
}

provider "aws" {
  region = var.region
}