output "openid_claims" {
  description = "OpenID Claims for trust relationship"
  value       = one(jsondecode(aws_iam_role.tfc_role.assume_role_policy).Statement).Condition
}

output "role_arn" {
  description = "ARN for trust relationship role"
  value       = aws_iam_role.tfc_role.arn
}

output "iam_policy_arn" {
  description = "Policy for trust relationship"
  value       = aws_iam_policy.tfc_policy.arn
}

output "iam_policy" {
  description = "Policy for trust relationship"
  value       = jsondecode(aws_iam_policy.tfc_policy.policy)
}
