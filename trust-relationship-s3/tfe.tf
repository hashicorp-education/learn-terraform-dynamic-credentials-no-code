# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "tfe" {
  hostname = var.tfc_hostname
}

resource "tfe_project" "s3_websites" {
  name         = var.tfc_project_name
  organization = var.tfc_organization_name
}

resource "tfe_variable_set" "s3_trust_relationship" {
  name         = "${var.tfc_project_name} ${var.tfc_variable_set_name}"
  description  = "Trust relationships for S3 buckets project."
  organization = var.tfc_organization_name
}

resource "tfe_project_variable_set" "s3_trust_relationship" {
  variable_set_id = tfe_variable_set.s3_trust_relationship.id
  project_id      = tfe_project.s3_websites.id
}

resource "tfe_variable" "enable_vault_provider_auth" {
  variable_set_id = tfe_variable_set.s3_trust_relationship.id

  key      = "TFC_VAULT_PROVIDER_AUTH"
  value    = "true"
  category = "env"

  description = "Enable the Workload Identity integration for Vault."
}

resource "tfe_variable" "tfc_vault_addr" {
  variable_set_id = tfe_variable_set.s3_trust_relationship.id

  key       = "TFC_VAULT_ADDR"
  value     = var.vault_url
  category  = "env"
  sensitive = true

  description = "The address of the Vault instance runs will access."
}

resource "tfe_variable" "tfc_vault_role" {
  variable_set_id = tfe_variable_set.s3_trust_relationship.id

  key      = "TFC_VAULT_RUN_ROLE"
  value    = vault_jwt_auth_backend_role.aws_secret_backend_role.role_name
  category = "env"

  description = "The Vault role runs will use to authenticate."
}

resource "tfe_variable" "tfc_vault_namespace" {
  variable_set_id = tfe_variable_set.s3_trust_relationship.id

  key      = "TFC_VAULT_NAMESPACE"
  value    = var.vault_namespace
  category = "env"

  description = "Namespace that contains the AWS Secrets Engine."
}

resource "tfe_variable" "enable_aws_provider_auth" {
  variable_set_id = tfe_variable_set.s3_trust_relationship.id

  key      = "TFC_VAULT_BACKED_AWS_AUTH"
  value    = "true"
  category = "env"

  description = "Enable the Vault Secrets Engine integration for AWS."
}

resource "tfe_variable" "tfc_aws_mount_path" {
  variable_set_id = tfe_variable_set.s3_trust_relationship.id

  key      = "TFC_VAULT_BACKED_AWS_MOUNT_PATH"
  value    = "aws"
  category = "env"

  description = "Path to where the AWS Secrets Engine is mounted in Vault."
}

resource "tfe_variable" "tfc_aws_auth_type" {
  variable_set_id = tfe_variable_set.s3_trust_relationship.id

  key      = "TFC_VAULT_BACKED_AWS_AUTH_TYPE"
  value    = vault_aws_secret_backend_role.aws_secret_backend_role.credential_type
  category = "env"

  description = "Role to assume via the AWS Secrets Engine in Vault."
}

resource "tfe_variable" "tfc_aws_run_role_arn" {
  variable_set_id = tfe_variable_set.s3_trust_relationship.id

  key      = "TFC_VAULT_BACKED_AWS_RUN_ROLE_ARN"
  value    = aws_iam_role.tfc_role.arn
  category = "env"

  description = "ARN of the AWS IAM Role the run will assume."
}

resource "tfe_variable" "tfc_aws_run_vault_role" {
  variable_set_id = tfe_variable_set.s3_trust_relationship.id

  key      = "TFC_VAULT_BACKED_AWS_RUN_VAULT_ROLE"
  value    = vault_aws_secret_backend_role.aws_secret_backend_role.name
  category = "env"

  description = "Name of the Role in Vault to assume via the AWS Secrets Engine."
}
