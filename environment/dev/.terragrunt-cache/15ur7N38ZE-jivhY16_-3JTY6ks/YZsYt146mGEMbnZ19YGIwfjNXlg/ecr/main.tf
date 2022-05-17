provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {}
}

resource "aws_ecr_repository" "ecr_repository" {
  name = local.repository_name
}
resource "null_resource" "build" {
  provisioner "local-exec" {
    #command = "./app/build-docker.sh"
    # working_dir = "./app"
    #working_dir = format("%s/../../../app", get_terragrunt_dir())
    command = "make build"
    working_dir = var.working_dir
    environment = {
      TAG               = var.image_tag
      REPO_REGION       = var.aws_region
      ECR_REPO_URL      = var.ecr_repository_url
      APP_NAME          = var.app_name
      ENV_NAME          = var.environment
    }
  }
  }