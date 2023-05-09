resource "aws_iam_user" "trust_relationships" {
  name = "tfe-trust-relationships"
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

resource "aws_iam_policy" "trust_relationships" {
  description = "TFC run policy"

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

resource "aws_iam_role_policy_attachment" "tfc_policy_attachment" {
  role       = aws_iam_role.trust_relationships.name
  policy_arn = aws_iam_policy.trust_relationships.arn
}

resource "tfe_variable_set" "aws_credentials" {
  name         = "AWS Credentials for trust relationships"
  description  = "AWS secret key and secret key ID to configure trust relationships."
  organization = var.tfc_organization_name
}

resource "tfe_project_variable_set" "aws_credentials" {
  variable_set_id = tfe_variable_set.aws_credentials.id
  project_id = tfe_project.trust_relationships.id
}

resource "tfe_variable" "aws_access_key_id" {
  key             = "AWS_ACCESS_KEY_ID"
  value           = aws_iam_access_key.trust_relationships.id
  category        = "env"
  sensitive       = true
  description     = "Secret key ID associated with the role used to create trust relationships"
  variable_set_id = tfe_variable_set.aws_credentials.id
}

resource "tfe_variable" "aws_secret_access_key" {
  key             = "AWS_SECRET_ACCESS_KEY"
  value           = aws_iam_access_key.trust_relationships.secret
  category        = "env"
  sensitive       = true
  description     = "Secret key associated with the role used to create trust relationships"
  variable_set_id = tfe_variable_set.aws_credentials.id
}
