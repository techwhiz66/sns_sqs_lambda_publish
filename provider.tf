# provider block

provider "aws" {
  profile = "default"
  region = var.aws_region
}

terraform {
  backend "s3" {
    encrypt         = true
    bucket          = "s3-tf-state-06162023"
   # dynamodb_table  = "my_dynamo_table_name"
    key             = "terraform.tfstate"
    region          = "us-east-1"
  }
}
