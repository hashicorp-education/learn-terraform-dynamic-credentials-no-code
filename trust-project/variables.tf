# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "aws_region" {
  type        = string
  default     = "us-east-2"
  description = "AWS region for all resources."
}

variable "tfc_hostname" {
  type        = string
  default     = "app.terraform.io"
  description = "The hostname of the TFC or TFE instance."
}

variable "tfc_organization_name" {
  type        = string
  description = "The name of your Terraform Cloud organization."
}

variable "tfc_trust_project_name" {
  type        = string
  default     = "Trust Relationships"
  description = "The name of the trust relationships project."
}

variable "tfc_trust_team_name" {
  type        = string
  default     = "Trust Relationships"
  description = "The name of the trust relationships team."
}

variable "vault_url" {
  type        = string
  description = "The URL of the Vault instance."
}

variable "vault_namespace" {
  type        = string
  default     = "admin"
  description = "The namespace of the Vault instance."
}

variable "jwt_backend_path" {
  type        = string
  default     = "jwt"
  description = "The path at which to mount the jwt auth backend in Vault."
}

variable "aws_secrets_backend_path" {
  type        = string
  default     = "aws"
  description = "The path at which to mount the aws secrets engine backend in Vault."
}

variable "vault_aws_secret_backend_policy_name" {
  type        = string
  default     = "aws_secret_backend_policy"
  description = "Name of AWS secrets backend Vault policy."
}

variable "vault_user_name" {
  type        = string
  default     = "trust_relationships"
  description = "Username used to create trust relationships in Vault."
  sensitive   = true
}

variable "tfc_variable_set_name" {
  type        = string
  default     = "Variables for trust relationships."
  description = "TFC Variable Set Name"
}

variable "project_prefix" {
  type        = string
  default     = "DEMO"
  description = "Prefix for the project and trust relationship."
}
