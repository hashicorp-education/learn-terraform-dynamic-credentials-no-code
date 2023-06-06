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

variable "tfc_project_name" {
  type        = string
  default     = "Default Project"
  description = "The name of the Terraform Cloud project."
}

variable "tfc_workspace_name" {
  type        = string
  description = "The name of the Terraform Cloud workspace."
}

variable "jwt_backend_path" {
  type        = string
  default     = "jwt"
  description = "The path for the jwt auth backend in Vault."
}

variable "vault_aws_secrets_backend_path" {
  type        = string
  description = "The path at which the AWS secret engine is mounted in Vault."
}

variable "vault_namespace" {
  type        = string
  default     = "admin"
  description = "The namespace of the Vault instance you'd like to create the AWS and jwt auth backends in."
}

variable "vault_url" {
  type        = string
  description = "URL of vault cluster."
  default     = "localhost:3000"
}

variable "tfc_vault_audience" {
  type        = string
  default     = "vault.workload.identity"
  description = "The audience value to use in run identity tokens."
}

variable "vault_aws_secrets_engine_user_name" {
  type        = string
  description = "Username of the AWS secrets engine user."
  default     = "trust_relationships"
}

variable "vault_policy_name" {
  type        = string
  description = "Name of the vault policy to use."
  default     = "trust_relationships"
}

variable "aws_iam_user_name" {
  type        = string
  description = "AWS IAM user name."
}

variable "aws_iam_user_arn" {
  type        = string
  description = "AWS IAM user ARN."
}

variable "vcs_oath_client_name" {
  type        = string
  description = "The name of the OAuth client."
}

variable "vcs_service_provider" {
  type        = string
  default     = "github"
  description = "The name of the VCS service provider."
}

variable "vcs_identifier" {
  type        = string
  description = "Identifier for VCS repositor."
}

variable "vcs_working_directory" {
  type        = string
  description = "Working directory inside VCS repository."
}
