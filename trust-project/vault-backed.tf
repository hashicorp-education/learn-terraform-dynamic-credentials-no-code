resource "aws_iam_user" "secrets_engine" {
  name = "hcp-vault-secrets-engine"
}

resource "aws_iam_access_key" "secrets_engine_credentials" {
  user = aws_iam_user.secrets_engine.name
}

resource "aws_iam_role" "tfc_role" {
  name = "tfc-role"

  assume_role_policy = jsonencode(
    {
      Statement = [
        {
          Action    = "sts:AssumeRole"
          Condition = {}
          Effect    = "Allow"
          Principal = {
            AWS = aws_iam_user.secrets_engine.arn
          }
        },
      ]
      Version = "2012-10-17"
    }
  )
}

resource "vault_aws_secret_backend" "aws_secret_backend" {
  namespace = var.vault_namespace
  path      = "aws"

  access_key = aws_iam_access_key.secrets_engine_credentials.id
  secret_key = aws_iam_access_key.secrets_engine_credentials.secret
}

resource "vault_aws_secret_backend_role" "aws_secret_backend_role" {
  backend         = vault_aws_secret_backend.aws_secret_backend.path
  name            = var.aws_secret_backend_role_name
  credential_type = "assumed_role"

  role_arns = [aws_iam_role.tfc_role.arn]
}

resource "vault_jwt_auth_backend" "tfc_jwt" {
  path               = var.jwt_backend_path
  type               = "jwt"
  oidc_discovery_url = "https://${var.tfc_hostname}"
  bound_issuer       = "https://${var.tfc_hostname}"
}

resource "vault_policy" "tfc_policy" {
  name = "tfc-secrets-engine-policy"

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
path "aws/sts/${var.aws_secret_backend_role_name}" {
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
  "policies": ["tfc-secrets-engine-policy"],
  "password": "${random_password.vault.result}"
}
EOT
}

resource "tfe_variable_set" "vault_credentials" {
  name         = var.tfc_variable_set_vault_credentials
  description  = "Vault Credentials for trust relationships project."
  organization = var.tfc_organization_name
}

resource "tfe_project_variable_set" "vault_credentials" {
  variable_set_id = tfe_variable_set.vault_credentials.id
  project_id      = tfe_project.trust_relationships.id
}

resource "tfe_variable" "tfc_vault_addr" {
  key             = "TFC_VAULT_ADDR"
  value           = var.vault_url
  category        = "env"
  sensitive       = true
  description     = "The address of the Vault instance runs will access."
  variable_set_id = tfe_variable_set.vault_credentials.id
}

resource "tfe_variable" "tfc_vault_policy_name" {
  key             = "TF_VAR_vault_policy_name"
  value           = vault_policy.tfc_policy.name
  category        = "env"
  description     = "The name of the vault policy."
  variable_set_id = tfe_variable_set.vault_credentials.id
}

resource "tfe_variable" "tfc_vault_url" {
  key             = "TF_VAR_vault_url"
  value           = var.vault_url
  category        = "env"
  sensitive       = true
  description     = "The address of the Vault instance runs will access."
  variable_set_id = tfe_variable_set.vault_credentials.id
}

resource "tfe_variable" "aws_iam_user_name" {
  key             = "TF_VAR_aws_iam_user_name"
  value           = aws_iam_user.secrets_engine.name
  category        = "env"
  description     = "The name of the AWS IAM user."
  variable_set_id = tfe_variable_set.vault_credentials.id
}

resource "tfe_variable" "aws_iam_user_arn" {
  key             = "TF_VAR_aws_iam_user_arn"
  value           = aws_iam_user.secrets_engine.arn
  category        = "env"
  description     = "The address of the Vault instance runs will access."
  variable_set_id = tfe_variable_set.vault_credentials.id
}

resource "tfe_variable" "tfc_aws_mount_path" {
  key             = "TFC_VAULT_BACKED_AWS_MOUNT_PATH"
  value           = vault_aws_secret_backend.aws_secret_backend.path
  category        = "env"
  description     = "Path to where the AWS Secrets Engine is mounted in Vault."
  variable_set_id = tfe_variable_set.vault_credentials.id
}

# resource "tfe_variable" "tfc_vault_token" {
#   key             = "VAULT_TOKEN"
#   value           = var.vault_token
#   category        = "env"
#   sensitive       = true
#   description     = "Vault token."
#   variable_set_id = tfe_variable_set.vault_credentials.id
# }

resource "tfe_variable" "tfc_vault_namespace" {
  key             = "VAULT_NAMESPACE"
  value           = "admin"
  category        = "env"
  description     = "Vault namespace."
  variable_set_id = tfe_variable_set.vault_credentials.id
}

resource "tfe_variable" "vault_aws_secrets_engine_user_name_env" {
  key             = "TERRAFORM_VAULT_USERNAME"
  value           = var.vault_user_name
  category        = "env"
#  sensitive = true
  description     = "Username of the vault secrets engine user."
  variable_set_id = tfe_variable_set.vault_credentials.id
}

resource "tfe_variable" "vault_aws_secrets_engine_user_name_terraform" {
  key             = "TF_VAR_vault_aws_secrets_engine_user_name"
  value           = var.vault_user_name
  category        = "env"
  sensitive = true
  description     = "Username of the vault secrets engine user."
  variable_set_id = tfe_variable_set.vault_credentials.id
}

resource "tfe_variable" "vault_aws_secrets_engine_user_password" {
  key             = "TERRAFORM_VAULT_PASSWORD"
  value           = random_password.vault.result
  category        = "env"
#  sensitive = true
  description     = "Password of the vault secrets engine user."
  variable_set_id = tfe_variable_set.vault_credentials.id
}

resource "tfe_variable" "vault_aws_secrets_engine_backend_role_name" {
  key             = "TF_VAR_aws_secrets_engine_backend_role_name"
  value           = vault_aws_secret_backend_role.aws_secret_backend_role.name
  category        = "env"
  description     = "Name of AWS secret backend role."
  variable_set_id = tfe_variable_set.vault_credentials.id
}
