#
# Terraform setup
#
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket         = "terraform-staging"
    key            = "state/aws"
    region         = "eu-west-2"
    dynamodb_table = "terraform-staging"
    profile        = "terraform-staging"
  }
}

#
# Providers
#
provider "aws" {
  region  = "eu-west-2"
  profile = "terraform-staging"

  default_tags {
    tags = {
      terraform   = "true"
      Environment = var.environment
      Owner       = var.owner
    }
  }
}

#
# Modules
#

module "terraform" {
  source = "./modules/terraform"
}

module "staging" {
  source = "./modules/staging"
}
