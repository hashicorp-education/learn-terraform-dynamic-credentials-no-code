# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "aws_region" {
  type        = string
  default     = "us-east-2"
  description = "AWS region for all resources"
}

variable "tfc_hostname" {
  type        = string
  default     = "app.terraform.io"
  description = "The hostname of the TFC or TFE instance"
}

variable "tfc_organization_name" {
  type        = string
  description = "The name of your Terraform Cloud organization"
}

variable "tfc_trust_project_name" {
  type        = string
  default     = "Trust Relationships"
  description = "The name of the trust relationships project"
}

variable "tfc_trust_team_name" {
  type        = string
  default     = "Trust Relationships"
  description = "The name of the trust relationships team"
}

variable "vault_url" {
  type        = string
  description = "The URL of the Vault instance"
}

variable "vault_token" {
  type        = string
  description = "The Vault token"
}

variable "vault_namespace" {
  type        = string
  default     = "admin"
  description = "The namespace of the Vault instance"
}

variable "jwt_backend_path" {
  type        = string
  default     = "jwt"
  description = "The path at which to mount the jwt auth backend in Vault"
}

variable "vault_aws_secret_backend_role_name" {
  type        = string
  description = "Name of AWS secrets backend Vault role"
  default     = "aws_secret_backend_role"
}

variable "vault_aws_secret_backend_policy_name" {
  type        = string
  description = "Name of AWS secrets backend Vault policy"
  default     = "aws_secret_backend_policy"
}

variable "vault_user_name" {
  type        = string
  description = "Username used to create trust relationships in vault"
  sensitive   = true
  default     = "trust_relationships"
}

variable "tfc_variable_set_name" {
  type        = string
  description = "TFC Variable Set Name"
  default     = "TFE Credentials for trust relationships"
}

variable "tfc_variable_set_vault_credentials" {
  type        = string
  description = "TFC variable set for Vault-Backed trust relationships"
  default     = "Configuration for Vault-Backed trust relationships"
}
