# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "aws_secrets_engine_backend_role_name" {
  type        = string
  description = "Name of AWS secret backend role for runs to use"
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

variable "tfc_project_name" {
  type        = string
  default     = "Default Project"
  description = "The project under which a workspace will be created"
}

variable "tfc_workspace_name" {
  type        = string
  default     = "vault-backed-aws-auth"
  description = "The name of the workspace that you'd like to create and connect to AWS"
}

# Variables for Vault

# variable "vault_url" {
#   type        = string
#   description = "The URL of the Vault instance you'd like to use with Terraform Cloud"
# }

variable "jwt_backend_path" {
  type        = string
  default     = "jwt"
  description = "The path at which you'd like to mount the jwt auth backend in Vault"
}

variable "vault_namespace" {
  type        = string
  default     = "admin"
  description = "The namespace of the Vault instance you'd like to create the AWS and jwt auth backends in"
}

variable "vault_url" {
  type        = string
  description = "URL of vault cluster"
}

variable "tfc_vault_audience" {
  type        = string
  default     = "vault.workload.identity"
  description = "The audience value to use in run identity tokens"
}

variable "vault_aws_secrets_engine_user_name" {
  type = string
  description = "Username of the AWS secrets engine user"
}

variable "vault_policy_name" {
  type = string
  description = "Name of the vault policy to use"
}

variable "aws_iam_user_name" {
  type = string
  description = "AWS IAM user name"
}

variable "aws_iam_user_arn" {
  type = string
  description = "AWS IAM user ARN"
}

variable "aws_region" {
  type        = string
  default     = "us-east-2"
  description = "AWS region for all resources"
}
