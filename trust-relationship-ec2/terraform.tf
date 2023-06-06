terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.1.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.15.2"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.45.0"
    }
  }

  required_version = "~> 1.2"
}
