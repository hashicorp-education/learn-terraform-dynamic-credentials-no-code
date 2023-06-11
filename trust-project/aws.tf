# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "aws" {
  region = var.aws_region
}

resource "random_string" "name_suffix" {
  length  = 6
  special = false
}

resource "aws_iam_user" "trust_relationships" {
  name = "vault-secrets-engine-${random_string.name_suffix.result}"
}

resource "aws_iam_access_key" "trust_relationships" {
  user = aws_iam_user.trust_relationships.name
}

resource "aws_iam_role" "trust_relationships" {
  assume_role_policy = jsonencode(
    {
      Statement = [
        {
          Action    = "sts:AssumeRole"
          Condition = {}
          Effect    = "Allow"
          Principal = {
            AWS = aws_iam_user.trust_relationships.arn
          }
        },
      ]
      Version = "2012-10-17"
    }
  )
}

resource "aws_iam_user_policy" "trust_relationships" {
  user = aws_iam_user.trust_relationships.name

  policy = jsonencode({
    Statement = [
      {
        Action = [
          "iam:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
    Version = "2012-10-17"
  })
}
