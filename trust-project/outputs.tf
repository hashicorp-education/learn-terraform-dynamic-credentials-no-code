# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "tfc_project_name" {
  description = "Name of the trust relationships project."
  value       = tfe_project.trust_relationships.name
}

output "tfc_org_name" {
  description = "Organization name."
  value       = var.tfc_organization_name
}

output "trust_relationships_arn" {
  description = "ARN of trust relationships IAM role."
  value       = aws_iam_role.trust_relationships.arn
}

output "trust_project_url" {
  description = "URL of trust relationships project."
  value       = "https://${var.tfc_hostname}/app/${var.tfc_organization_name}/workspaces?project=${tfe_project.trust_relationships.id}"
}

output "trust_varset_url" {
  description = "URL of the variable set for the trust relationships project."
  value       = "https://${var.tfc_hostname}/app/${var.tfc_organization_name}/settings/varsets/${tfe_variable_set.trust_relationships.id}"
}
