# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.45.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.1.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.15.2"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.1"
    }
  }

  required_version = "~> 1.2"
}
