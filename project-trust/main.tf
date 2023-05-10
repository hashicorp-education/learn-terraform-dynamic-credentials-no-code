# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "aws" {
  region = var.aws_region
}

provider "tfe" {
  hostname = var.tfc_hostname
}

provider "vault" {
  address = var.vault_url
}

resource "tfe_project" "trust_relationships" {
  name         = var.tfc_project_name
  organization = var.tfc_organization_name
}
