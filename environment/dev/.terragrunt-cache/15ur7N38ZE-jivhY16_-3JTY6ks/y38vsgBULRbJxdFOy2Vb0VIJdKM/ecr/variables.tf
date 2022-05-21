locals {
  repository_name = format("%s-%s", var.app_name, var.environment)
}

variable "ecr_repository_url" {
  type = string
  default = "873432059572.dkr.ecr.eu-central-1.amazonaws.com"
}

variable "environment" {}

variable "app_name" {}

variable "image_tag" {
  type = string
  default = "v1"
}

variable "aws_region" {}