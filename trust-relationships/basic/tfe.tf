provider "tfe" {
  hostname = var.tfc_hostname
}

data "tfe_oauth_client" "client" {
  organization = var.tfc_organization_name
  name = var.vcs_oath_client_name
  service_provider = var.vcs_service_provider
}

resource "tfe_workspace" "trusted_workspace" {
  name         = var.tfc_workspace_name
  organization = var.tfc_organization_name
  working_directory = var.vcs_working_directory

  vcs_repo {
    identifier = var.vcs_identifier
    oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
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
