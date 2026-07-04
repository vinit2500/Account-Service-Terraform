variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "environment" {
  description = "Deployment Environment"
  type        = string
}

variable "product_name" {
  description = "Product Name"
  type        = string
}

variable "common_tags" {
  description = "Common resource tags"
  type        = map(string)
}