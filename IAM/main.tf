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


# module "ec2_module" {
#     sg_name = module.sg_module.sg_name_output 
#     ec2_name = "ec2 name from module"
#     source = "./ec2_module"
# }

# module "sg_module" {
#     source = "./sg_module"
# }


module "group1" {
  source = "./module_group"
}

module "user1" {
    grp_name = "${module.group1.group_name}"
  source = "./module_user"
}

module "policy1" {
  source = "./module_policy"
}
