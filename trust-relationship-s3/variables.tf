# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

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
  default     = "S3 Websites"
  description = "The project under which a workspace will be created"
}

variable "tfc_workspace_name" {
  type        = string
  description = "The name of the workspace that you'd like to create and connect to AWS"
  default     = "*"
}

variable "jwt_backend_path" {
  type        = string
  default     = "jwt"
  description = "The path at which you'd like to mount the jwt auth backend in Vault"
}

variable "vault_aws_secrets_backend_path" {
  type        = string
  description = "The path at which the AWS secret engine is mounted in Vault"
}

variable "vault_namespace" {
  type        = string
  default     = "admin"
  description = "The namespace of the Vault instance you'd like to create the AWS and jwt auth backends in"
}

variable "vault_url" {
  type        = string
  description = "URL of vault cluster"
  default     = "localhost:3000"
}

variable "tfc_vault_audience" {
  type        = string
  default     = "vault.workload.identity"
  description = "The audience value to use in run identity tokens"
}

variable "vault_aws_secrets_engine_user_name" {
  type        = string
  description = "Username of the AWS secrets engine user"
  default     = "trust_relationships"
}

variable "vault_policy_name" {
  type        = string
  description = "Name of the vault policy to use"
  default     = "trust_relationships"
}

variable "aws_iam_user_name" {
  type        = string
  description = "AWS IAM user name"
  default     = "trust_relationships"
}

variable "aws_iam_user_arn" {
  type        = string
  description = "AWS IAM user ARN"
}

variable "aws_region" {
  type        = string
  default     = "us-east-2"
  description = "AWS region for all resources"
}

variable "tfc_variable_set_name" {
  type        = string
  default     = "S3 Buckets trust relationship"
  description = "TFC Variable Set Name"
}
