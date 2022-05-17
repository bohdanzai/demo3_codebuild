terraform {
  source = "/home/bohdan/Dev_ops/terragrunt_vpc/modules//vpc"
  extra_arguments "custom_vars" {
    commands = get_terraform_commands_that_need_vars()
  }
}

locals {
  remote_state_bucket_prefix = "tfstate"
  environment = "dev"
  app_name = "demo3"
  aws_account = "873432059572"
  aws_region = "eu-central-1"
  image_tag = "v1"  
}

inputs = {
  remote_state_bucket = format("%s-%s-%s-%s", local.remote_state_bucket_prefix, local.app_name, local.environment, local.aws_region)
  environment = local.environment
  app_name = local.app_name
  aws_account = local.aws_account
  aws_region = local.aws_region
  image_tag = local.image_tag
}

remote_state {
  backend = "s3"

  config = {
    encrypt        = true
    bucket         = format("%s-%s-%s-%s", local.remote_state_bucket_prefix, local.app_name, local.environment, local.aws_region)
    key            = format("%s/terraform.tfstate", path_relative_to_include())
    region         = local.aws_region
    # dynamodb_table = format("tflock-%s-%s-%s", local.environment, local.app_name, local.aws_region)
    dynamodb_table = "my-lock-table"
  }
}

# remote_state {
#   backend = "s3"
#   config = {
#     bucket         = "tfstate.us-east-2.bohdanzai"
#     key            = "${path_relative_to_include()}/terraform.tfstate"
#     region         = "us-east-2"
#     encrypt        = true
#     dynamodb_table = "my-lock-table"
#   }
# }
