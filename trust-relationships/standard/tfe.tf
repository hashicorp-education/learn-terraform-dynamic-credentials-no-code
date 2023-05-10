# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "tfe" {
  hostname = var.tfc_hostname
}

resource "tfe_workspace" "trusted_workspace" {
  name         = var.tfc_workspace_name
  organization = var.tfc_organization_name
  working_directory = "/infra"
  vcs_repo {
    identifier = "robin-norwood/learn-terraform-dynamic-credentials-workshop"
  }
}

resource "tfe_variable" "enable_aws_provider_auth" {
  workspace_id = tfe_workspace.trusted_workspace.id

  key      = "TFC_AWS_PROVIDER_AUTH"
  value    = "true"
  category = "env"

  description = "Enable the Workload Identity integration for AWS."
}

resource "tfe_variable" "tfc_aws_role_arn" {
  workspace_id = tfe_workspace.trusted_workspace.id

  key      = "TFC_AWS_RUN_ROLE_ARN"
  value    = aws_iam_role.tfc_role.arn
  category = "env"

  description = "The AWS role arn runs will use to authenticate."
}
