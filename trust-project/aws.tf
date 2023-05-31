provider "aws" {
  region = var.aws_region
}

resource "aws_iam_user" "secrets_engine" {
  name = "vault-secrets-engine"
}

resource "aws_iam_access_key" "secrets_engine_credentials" {
  user = aws_iam_user.secrets_engine.name
}

resource "aws_iam_role" "secrets_engine" {
  assume_role_policy = jsonencode(
    {
      Statement = [
        {
          Action    = "sts:AssumeRole"
          Condition = {}
          Effect    = "Allow"
          Principal = {
            AWS = aws_iam_user.secrets_engine.arn
          }
        },
      ]
      Version = "2012-10-17"
    }
  )
}
