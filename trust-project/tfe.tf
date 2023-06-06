# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "tfe" {
  hostname = var.tfc_hostname
}

resource "tfe_project" "trust_relationships" {
  name         = "${var.project_prefix} ${var.tfc_trust_project_name}"
  organization = var.tfc_organization_name
}

resource "tfe_team" "trust_relationships" {
  name         = "${var.project_prefix} ${var.tfc_trust_team_name}"
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

resource "tfe_variable_set" "trust_relationships" {
  name         = "${var.project_prefix} ${var.tfc_variable_set_name}"
  description  = "Variables required to create trust relationships."
  organization = var.tfc_organization_name
}

resource "tfe_project_variable_set" "trust_relationships" {
  variable_set_id = tfe_variable_set.trust_relationships.id
  project_id      = tfe_project.trust_relationships.id
}

resource "tfe_variable" "organization_name" {
  key             = "tfc_organization_name"
  value           = var.tfc_organization_name
  category        = "terraform"
  description     = "organization name"
  variable_set_id = tfe_variable_set.trust_relationships.id
}

resource "tfe_variable" "tfe_token" {
  key             = "TFE_TOKEN"
  value           = tfe_team_token.trust_relationships.token
  category        = "env"
  sensitive       = true
  description     = "Team token"
  variable_set_id = tfe_variable_set.trust_relationships.id
}

resource "tfe_variable" "tfc_vault_addr" {
  key             = "TFC_VAULT_ADDR"
  value           = var.vault_url
  category        = "env"
  sensitive       = true
  description     = "The address of the Vault instance runs will access."
  variable_set_id = tfe_variable_set.trust_relationships.id
}

resource "tfe_variable" "tfc_vault_policy_name" {
  key             = "TF_VAR_vault_policy_name"
  value           = vault_policy.trust_policy.name
  category        = "env"
  description     = "The name of the vault policy."
  variable_set_id = tfe_variable_set.trust_relationships.id
}

resource "tfe_variable" "tfc_vault_url" {
  key             = "TF_VAR_vault_url"
  value           = var.vault_url
  category        = "env"
  sensitive       = true
  description     = "The address of the Vault instance runs will access."
  variable_set_id = tfe_variable_set.trust_relationships.id
}

resource "tfe_variable" "aws_iam_user_name" {
  key             = "TF_VAR_aws_iam_user_name"
  value           = aws_iam_user.trust_relationships.name
  category        = "env"
  description     = "The name of the AWS IAM user."
  variable_set_id = tfe_variable_set.trust_relationships.id
}

resource "tfe_variable" "aws_iam_user_arn" {
  key             = "TF_VAR_aws_iam_user_arn"
  value           = aws_iam_user.trust_relationships.arn
  category        = "env"
  description     = "The address of the Vault instance runs will access."
  variable_set_id = tfe_variable_set.trust_relationships.id
}

resource "tfe_variable" "tfc_aws_mount_path" {
  key             = "TFC_VAULT_BACKED_AWS_MOUNT_PATH"
  value           = vault_aws_secret_backend.aws_secret_backend.path
  category        = "env"
  description     = "Path to where the AWS Secrets Engine backend is mounted in Vault."
  variable_set_id = tfe_variable_set.trust_relationships.id
}

resource "tfe_variable" "tfc_aws_mount_path_tf" {
  key             = "TF_VAR_vault_aws_secrets_backend_path"
  value           = vault_aws_secret_backend.aws_secret_backend.path
  category        = "env"
  description     = "Path to where the AWS Secrets Engine backend is mounted in Vault."
  variable_set_id = tfe_variable_set.trust_relationships.id
}

resource "tfe_variable" "tfc_vault_namespace" {
  key             = "VAULT_NAMESPACE"
  value           = "admin"
  category        = "env"
  description     = "Vault namespace."
  variable_set_id = tfe_variable_set.trust_relationships.id
}

resource "tfe_variable" "vault_aws_secrets_engine_user_name_env" {
  key             = "TERRAFORM_VAULT_USERNAME"
  value           = var.vault_user_name
  category        = "env"
  sensitive       = true
  description     = "Username of the vault secrets engine user."
  variable_set_id = tfe_variable_set.trust_relationships.id
}

resource "tfe_variable" "vault_aws_secrets_engine_user_name_terraform" {
  key             = "TF_VAR_vault_aws_secrets_engine_user_name"
  value           = var.vault_user_name
  category        = "env"
  sensitive       = true
  description     = "Username of the vault secrets engine user."
  variable_set_id = tfe_variable_set.trust_relationships.id
}

resource "tfe_variable" "vault_aws_secrets_engine_user_password" {
  key             = "TERRAFORM_VAULT_PASSWORD"
  value           = random_password.vault.result
  category        = "env"
  sensitive       = true
  description     = "Password of the vault secrets engine user."
  variable_set_id = tfe_variable_set.trust_relationships.id
}

resource "tfe_variable" "aws_access_key_id" {
  key             = "AWS_ACCESS_KEY_ID"
  value           = aws_iam_access_key.trust_relationships.id
  category        = "env"
  sensitive       = true
  description     = "Secret key ID associated with the role used to create trust relationships"
  variable_set_id = tfe_variable_set.trust_relationships.id
}

resource "tfe_variable" "aws_secret_access_key" {
  key             = "AWS_SECRET_ACCESS_KEY"
  value           = aws_iam_access_key.trust_relationships.secret
  category        = "env"
  sensitive       = true
  description     = "Secret key associated with the role used to create trust relationships"
  variable_set_id = tfe_variable_set.trust_relationships.id
}
