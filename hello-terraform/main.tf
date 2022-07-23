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

resource "aws_instance" "my-first-server"{
    ami= "ami-052efd3df9dad4825"
    instance_type = "t2.micro"

    tags = {
    Name = "ubuntu-server"
  }

}

resource "aws_vpc" "first-vpc" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "prod-vpc"
  }
}

resource "aws_subnet" "first-subnet" {
    vpc_id = aws_vpc.first-vpc.id
    cidr_block = "10.0.1.0/24"
    tags = {
        Name = "prod-subnet"
  }
}


