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
  name         = var.tfc_trust_project_name
  organization = var.tfc_organization_name
}

resource "tfe_team" "trust_relationships" {
  name         = var.tfc_trust_team_name
  organization = var.tfc_organization_name
  organization_access {
    read_workspaces   = true
    read_projects     = true
    manage_workspaces = true
    manage_projects   = true
  }
}

resource "tfe_team_token" "trust_relationships" {
  team_id = tfe_team.trust_relationships.id
}

resource "tfe_variable_set" "tfe_credentials" {
  name         = var.tfc_variable_set_name
  description  = "TFE token and organization name for trust relationships."
  organization = var.tfc_organization_name
}

resource "tfe_project_variable_set" "tfe_credentials" {
  variable_set_id = tfe_variable_set.tfe_credentials.id
  project_id      = tfe_project.trust_relationships.id
}

resource "tfe_variable" "organization_name" {
  key             = "tfc_organization_name"
  value           = var.tfc_organization_name
  category        = "terraform"
  description     = "organization name"
  variable_set_id = tfe_variable_set.tfe_credentials.id
}

resource "tfe_variable" "tfe_token" {
  key             = "TFE_TOKEN"
  value           = tfe_team_token.trust_relationships.token
  category        = "env"
  sensitive       = true
  description     = "Team token"
  variable_set_id = tfe_variable_set.tfe_credentials.id
}
