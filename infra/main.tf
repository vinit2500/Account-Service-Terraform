module "ecr" {

  source = "./modules/ecr"
  repository_name = var.product_name
}

module "vpc" {

  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr

}