# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "tfc_project_name" {
  description = "Name of the trust relationships project"
  value       = tfe_project.trust_relationships.name
}

output "tfc_org_name" {
  description = "Organization name"
  value       = var.tfc_organization_name
}

output "trust_relationships_arn" {
  value = aws_iam_role.trust_relationships.arn
}
