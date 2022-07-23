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
# resource ""



# Resource policy

# attach policy to role

# lambda function

# data archive


