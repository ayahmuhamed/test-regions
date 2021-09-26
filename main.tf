terraform {
  required_providers = {
    aws = {
      source = "hashicorp/aws"
    }
  }

  # (if you had a backend configuration in your
  # old root module then move that into here too)
}

provider "aws" {
  alias = "eu-west-1"

  region = "eu-west-1"
}

provider "aws" {
  alias = "eu-south-1"

  region = "eu-south-1"
}

module "eu-west-1" {
  source = "./modules/region"

  vpc_cidr     = “10.10.10.0/24”
  subnet1_cidr = “10.10.10.0/25”
  subnet2_cidr = “10.10.10.128/25”
  my_ami       = “ami-038d7b856fe7557b3”

  providers = {
    aws = aws.eu-west-1
  }
}

module "eu-south-1" {
  source = "./modules/region"

  vpc_cidr     = “10.10.20.0/24”
  subnet1_cidr = “10.10.20.0/25”
  subnet2_cidr = “10.10.20.128/25”
  my_ami       = “ami-063c648dab7687f2b”

  providers = {
    aws = aws.eu-south-1
  }
}
