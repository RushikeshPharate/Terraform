
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
  region = "us-east-2"
  shared_credentials_file = "/Users/rushikeshpharate/.aws/credentials"
}


module "s3_module" {
  source = "./s3_module"
}

module "lambda_role_module" {
  source = "./lambda_role_module"
}

module "lambda_module" {
  source = "./lambda_module"
  lambda_role_arn= module.lambda_role_module.lambda_role_arn
  s3_bucket_arn = module.s3_module.s3_bucket_arn
  s3_bucket_id = module.s3_module.s3_bucket_id
}



