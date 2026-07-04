terraform {
  backend "s3" {
    bucket         = "account-service-dev-terraform-state"
    key            = "infra/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "account-service-dev-terraform-lock"
  }
}