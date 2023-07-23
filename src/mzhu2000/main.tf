provider "aws" {
  profile = var.profile
  region  = var.region
}

terraform {
  required_version = ">=1.5.3"
  backend "s3" {
    bucket         = "mzhu2000-s3-terraform-backend"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"

    # Replace this with your DynamoDB table name!
    dynamodb_table = "mzhu2000-terraform-locks"
    encrypt        = true
  }
}

module "vpc" {
  source = "../modules/vpc"
}

module "public_subnet" {
  source = "../modules/public-subnet"

  vpc_id = module.vpc.vpc_id
}

module "private_subnet" {
  source = "../modules/private-subnet"

  vpc_id = module.vpc.vpc_id
}

module "internet_gateway" {
  source = "../modules/internet-gateway"

  vpc_id = module.vpc.vpc_id
}

module "route_table" {
  source = "../modules/route-table"

  vpc_id              = module.vpc.vpc_id
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  #public_subnet_id    = module.public_subnet.public_subnet_id
  private_subnet_id    = module.private_subnet.private_subnet_id
}

module "ec2" {
  source = "../modules/ec2"

  vpc_id                  = module.vpc.vpc_id
  #public_subnet_id        = module.public_subnet.public_subnet_id
  private_subnet_id       = module.private_subnet.private_subnet_id

  ec2_ssh_key_name        = var.ec2_ssh_key_name
  ec2_ssh_public_key_path = var.ec2_ssh_public_key_path
}