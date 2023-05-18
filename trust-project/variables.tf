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
  description = "The hostname of the TFC or TFE instance you'd like to use with Vault"
}

variable "tfc_organization_name" {
  type        = string
  description = "The name of your Terraform Cloud organization"
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
  description = "The URL of the Vault instance you'd like to use with Terraform Cloud"
}

variable "vault_token" {
  type        = string
  description = "The Vault token"
}

variable "vault_namespace" {
  type        = string
  default     = "admin"
  description = "The namespace of the Vault instance you'd like to create the AWS and jwt auth backends in"
}

variable "jwt_backend_path" {
  type        = string
  default     = "jwt"
  description = "The path at which you'd like to mount the jwt auth backend in Vault"
}

variable "aws_secret_backend_role_name" {
  type        = string
  description = "Name of AWS secret backend role for runs to use"
}

variable "vault_user_name" {
  type = string
  description = "Username used to create trust relationships in vault"
  default = "trust_relationships"
}
