provider "vault" {
  address = var.vault_url
}

resource "vault_aws_secret_backend" "aws_secret_backend" {
  namespace = var.vault_namespace
  path      = "aws"

  access_key = aws_iam_access_key.trust_relationships.id
  secret_key = aws_iam_access_key.trust_relationships.secret
}

resource "vault_aws_secret_backend_role" "aws_secret_backend_role" {
  backend         = vault_aws_secret_backend.aws_secret_backend.path
  name            = var.vault_aws_secret_backend_role_name
  credential_type = "assumed_role"

  role_arns = [aws_iam_role.trust_relationships.arn]
}

resource "vault_jwt_auth_backend" "tfc_jwt" {
  path               = var.jwt_backend_path
  type               = "jwt"
  oidc_discovery_url = "https://${var.tfc_hostname}"
  bound_issuer       = "https://${var.tfc_hostname}"
}

resource "vault_policy" "tfc_policy" {
  name = var.vault_aws_secret_backend_policy_name

  policy = <<EOT
# Allow tokens to query themselves
path "auth/token/lookup-self" {
  capabilities = ["read"]
}

# Allow tokens to renew themselves
path "auth/token/renew-self" {
    capabilities = ["update"]
}

# Allow tokens to revoke themselves
path "auth/token/revoke-self" {
    capabilities = ["update"]
}

# Allow Access to AWS Secrets Engine
path "aws/sts/*" {
  capabilities = [ "read" ]
}

path "auth/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
EOT
}

resource "random_password" "vault" {
  length = 24
}

resource "vault_auth_backend" "userpass" {
  type = "userpass"
}

resource "vault_generic_endpoint" "trust_relationships" {
  depends_on           = [vault_auth_backend.userpass]
  path                 = "auth/userpass/users/${var.vault_user_name}"
  ignore_absent_fields = true

  data_json = <<EOT
{
  "policies": ["${vault_policy.tfc_policy.name}"],
  "password": "${random_password.vault.result}"
}
EOT
}
