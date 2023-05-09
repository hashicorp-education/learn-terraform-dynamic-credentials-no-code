output "tfc_project_name" {
  description = "Name of the trust relationships project"
  value       = tfe_project.trust_relationships.name
}

output "tfc_org_name" {
  description = "Organization name"
  value       = var.tfc_organization_name
}
