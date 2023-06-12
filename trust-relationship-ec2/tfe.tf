# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "tfe" {
  hostname = var.tfc_hostname
}

data "tfe_oauth_client" "client" {
  organization     = var.tfc_organization_name
  name             = var.vcs_oath_client_name
  service_provider = var.vcs_service_provider
}

resource "tfe_workspace" "trusted_workspace" {
  name              = var.tfc_workspace_name
  organization      = var.tfc_organization_name
  queue_all_runs    = false

  working_directory = var.vcs_working_directory

  vcs_repo {
    identifier     = var.vcs_identifier
    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
  }
}

resource "tfe_variable" "enable_vault_provider_auth" {
  workspace_id = tfe_workspace.trusted_workspace.id

  key      = "TFC_VAULT_PROVIDER_AUTH"
  value    = "true"
  category = "env"

  description = "Enable the Workload Identity integration for Vault."
}

resource "tfe_variable" "tfc_vault_addr" {
  workspace_id = tfe_workspace.trusted_workspace.id

  key       = "TFC_VAULT_ADDR"
  value     = var.vault_url
  category  = "env"
  sensitive = true

  description = "The address of the Vault instance runs will access."
}

resource "tfe_variable" "tfc_vault_role" {
  workspace_id = tfe_workspace.trusted_workspace.id

  key      = "TFC_VAULT_RUN_ROLE"
  value    = vault_jwt_auth_backend_role.aws_secret_backend_role.role_name
  category = "env"

  description = "The Vault role runs will use to authenticate."
}

resource "tfe_variable" "tfc_vault_namespace" {
  workspace_id = tfe_workspace.trusted_workspace.id

  key      = "TFC_VAULT_NAMESPACE"
  value    = var.vault_namespace
  category = "env"

  description = "Namespace that contains the AWS Secrets Engine."
}

resource "tfe_variable" "enable_aws_provider_auth" {
  workspace_id = tfe_workspace.trusted_workspace.id

  key      = "TFC_VAULT_BACKED_AWS_AUTH"
  value    = "true"
  category = "env"

  description = "Enable the Vault Secrets Engine integration for AWS."
}

resource "tfe_variable" "tfc_aws_mount_path" {
  workspace_id = tfe_workspace.trusted_workspace.id

  key      = "TFC_VAULT_BACKED_AWS_MOUNT_PATH"
  value    = "aws"
  category = "env"

  description = "Path to where the AWS Secrets Engine is mounted in Vault."
}

resource "tfe_variable" "tfc_aws_auth_type" {
  workspace_id = tfe_workspace.trusted_workspace.id

  key      = "TFC_VAULT_BACKED_AWS_AUTH_TYPE"
  value    = vault_aws_secret_backend_role.aws_secret_backend_role.credential_type
  category = "env"

  description = "Authentication type of Vault AWS secrets backend."
}

resource "tfe_variable" "tfc_aws_run_role_arn" {
  workspace_id = tfe_workspace.trusted_workspace.id

  key      = "TFC_VAULT_BACKED_AWS_RUN_ROLE_ARN"
  value    = aws_iam_role.tfc_role.arn
  category = "env"

  description = "ARN of the AWS IAM Role the dynamic credentials will assume."
}

resource "tfe_variable" "tfc_aws_run_vault_role" {
  workspace_id = tfe_workspace.trusted_workspace.id

  key      = "TFC_VAULT_BACKED_AWS_RUN_VAULT_ROLE"
  value    = vault_aws_secret_backend_role.aws_secret_backend_role.name
  category = "env"

  description = "Name of the Vault role to assume for the AWS Secrets Engine."
}
