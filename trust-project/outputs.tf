output "tfc_project_name" {
  description = "Name of the trust relationships project"
  value       = tfe_project.trust_relationships.name
}

output "tfc_org_name" {
  description = "Organization name"
  value       = var.tfc_organization_name
}

output "vault_username" {
  value     = var.vault_user_name
  sensitive = true
}

output "vault_password" {
  value     = random_password.vault.result
  sensitive = true
}

output "trust_relationships_arn" {
  value = aws_iam_role.trust_relationships.arn
}
