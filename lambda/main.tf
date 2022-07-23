terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  shared_credentials_file = "/Users/rushikeshpharate/.aws/credentials"
}


# IAM role

resource "aws_iam_role" "iam-role" {
  name = "lambda-iam-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}



# Resource policy
resource "aws_iam_policy" "iam-policy" {
  name        = "lambda_iam_role"
  path        = "/"
  description = "lambda_role_policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"  
        Resource = "arn:aws:logs:*:*:*"
      },
    ]
  })
}


# attach policy to role
resource "aws_iam_role_policy_attachment" "lambda-role-policy-attach" {
  role       = aws_iam_role.iam-role.name
  policy_arn = aws_iam_policy.iam-policy.arn
}



# data archive

data "archive_file" "lambda-zip" {
  type        = "zip"
  source_file = "${path.module}/python/main.py"
  output_path = "${path.module}/python/main.zip"
}



# lambda

resource "aws_lambda_function" "lambda-function" {
  # If the file is not in the current working directory you will need to include a 
  # path.module in the filename.
  filename      = "${path.module}/python/main.zip"
  function_name = "lambda_function_name"
  role          = aws_iam_role.iam-role.arn
  handler       = "main.lambda_handler"

    runtime = "python3.8"
    source_code_hash = filebase64sha256("${path.module}/python/main.zip")
    depends_on = [
      aws_iam_role_policy_attachment.lambda-role-policy-attach
    ]

  environment {
    variables = {
      foo = "bar"
    }
  }
}

