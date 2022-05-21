locals {
  repository_name = format("%s-%s", var.app_name, var.environment)
}

variable "region" {
  type    = string
  default = "us-east-2"
}

variable "ecr_repository_url" {
  type = string
  default = "873432059572.dkr.ecr.us-east-2.amazonaws.com"
}

# variable "environment" {}

# variable "app_name" {}

variable "image_tag" {
  type = string
  default = "v1"
}

# variable "aws_region" {}

variable "environment" {
  default = "dev"
}

variable "aws_region" {
  type    = string
  default = "us-east-2"
}

variable "app_name" {
    type = string
    default = "demo3"
}

variable "working_dir" {
    type = string
}