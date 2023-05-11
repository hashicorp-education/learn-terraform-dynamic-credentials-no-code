variable "aws_region" {
  type        = string
  default     = "us-east-2"
  description = "AWS region for all resources"
}

variable "tfc_aws_audience" {
  type        = string
  default     = "aws.workload.identity"
  description = "The audience value to use in run identity tokens"
}

variable "tfc_hostname" {
  type        = string
  default     = "app.terraform.io"
  description = "The hostname of the TFC or TFE instance you'd like to use with AWS"
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
  description = "The name of the workspace that you'd like to create and connect to AWS"
}

variable "vcs_identifier" {
  type = string
  description = "Identifier for VCS repo"
  default = "robin-norwood/learn-terraform-dynamic-credentials-workshop"
}

variable "vcs_working_directory" {
  type = string
  description = "Working directory"
  default = "/infra"
}

variable "vcs_oath_client_name" {
  type = string
  description = "Name of OAuth client"
  default = "GitHub.com (robin)"
}

variable "vcs_service_provider" {
  type = string
  descriptio = "VCS service provider"
  default = "github"
}
