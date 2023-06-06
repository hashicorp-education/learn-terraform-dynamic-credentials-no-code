output "openid_claims" {
  description = "OpenID Claims for trust relationship"
  value       = vault_jwt_auth_backend_role.aws_secret_backend_role.bound_claims
}

output "role_arn" {
  description = "ARN for trust relationship role"
  value       = aws_iam_role.tfc_role.arn
}

output "policy" {
  description = "Policy for this trust relationship"
  value       = aws_iam_policy.tfc_policy.policy
}
