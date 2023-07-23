provider "aws" {
  profile = var.profile
  region  = var.region
}

terraform {
  required_version = ">=1.5.3"
}

module "s3" {
  source = "../modules/s3"

  #s3_bucket_id  = module.s3.s3_bucket_id

}

module "dynamodb" {
  source = "../modules/dynamodb"

  #dynamodb_table_name = module.dynamodb.dynamodb_table_name

}