# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "aws" {
  region = var.aws_region
}

resource "aws_iam_user_policy" "vault_secrets_engine_generate_credentials" {
  user = var.aws_iam_user_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
        ]
        Effect   = "Allow"
        Resource = "${aws_iam_role.tfc_role.arn}"
      },
    ]
  })
}

resource "aws_iam_role" "tfc_role" {
  assume_role_policy = jsonencode(
    {
      Statement = [
        {
          Action    = "sts:AssumeRole"
          Condition = {}
          Effect    = "Allow"
          Principal = {
            AWS = var.aws_iam_user_arn
          }
        },
      ]
      Version = "2012-10-17"
    }
  )
}

resource "aws_iam_policy" "tfc_policy" {
  description = "TFC run policy"

  policy = jsonencode({
    Statement = [
      {
        Action = [
          "ec2:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "tfc_policy_attachment" {
  role       = aws_iam_role.tfc_role.name
  policy_arn = aws_iam_policy.tfc_policy.arn
}
