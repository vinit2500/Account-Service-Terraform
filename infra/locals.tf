locals {

  name_prefix = "${var.product_name}-${var.environment}"

  state_bucket_name = "${local.name_prefix}-terraform-state"

  lock_table_name = "${local.name_prefix}-terraform-lock"

  common_tags = merge(
    var.common_tags,
    {
      Environment = var.environment
      Product     = var.product_name
      ManagedBy   = "Terraform"
    }
  )
}