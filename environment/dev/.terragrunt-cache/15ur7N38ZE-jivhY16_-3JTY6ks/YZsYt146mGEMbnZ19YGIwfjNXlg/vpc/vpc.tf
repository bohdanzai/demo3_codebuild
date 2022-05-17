provider "aws" {
  region  = var.region
}

resource "aws_vpc" "dev_vpc" {
  cidr_block       = var.cidr
  instance_tenancy = "default"
  tags = {
    Name = "${var.environment}-vpc"
  }
}

terraform {
  backend "s3" {}
}
