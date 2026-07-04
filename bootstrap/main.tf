module "bootstrap" {

  source = "./modules"

  bucket_name     = local.state_bucket_name
  lock_table_name = local.lock_table_name

}