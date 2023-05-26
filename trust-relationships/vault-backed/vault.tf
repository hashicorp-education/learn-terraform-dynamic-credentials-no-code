# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "vault" {
  address = var.vault_url

  auth_login_userpass {
    namespace = var.vault_namespace
  }
}

resource "vault_jwt_auth_backend_role" "tfc_role" {
#  namespace      = var.vault_namespace
  backend        = var.jwt_backend_path
  role_name      = "tfc-role"
  token_policies = [var.vault_policy_name]

  bound_audiences   = [var.tfc_vault_audience]
  bound_claims_type = "glob"
  bound_claims = {
    sub = "organization:${var.tfc_organization_name}:project:${var.tfc_project_name}:workspace:${var.tfc_workspace_name}:run_phase:*"
  }

  user_claim = "terraform_full_workspace"
  role_type  = "jwt"
  token_ttl  = 1200
}
