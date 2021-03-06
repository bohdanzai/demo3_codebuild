locals {
  remote_state_bucket_prefix = "tfstate"
  environment = "dev"
  app_name = "demo3"
  aws_account = "873432059572"
  # aws_profile = "default"
  aws_region = "eu-central-1"
  image_tag = "0.0.1"  

  repo_url = "https://github.com/bohdanzai/demo3_codebuild.git"
  branch_pattern = "^refs/heads/master$"
  git_trigger_event = "PUSH"
  app_count = 1
}

inputs = {
  remote_state_bucket = format("%s-%s-%s-%s", local.remote_state_bucket_prefix, local.app_name, local.environment, local.aws_region)
  environment = local.environment
  app_name = local.app_name
  aws_account = local.aws_account
  # aws_profile = local.aws_profile
  aws_region = local.aws_region
  image_tag = local.image_tag
  repo_url = local.repo_url
  branch_pattern = local.branch_pattern
  git_trigger_event = local.git_trigger_event
  app_count = local.app_count
}

remote_state {
  backend = "s3"
  
  config = {
    encrypt        = true
    bucket         = format("%s-%s-%s-%s", local.remote_state_bucket_prefix, local.app_name, local.environment, local.aws_region)
    key            = format("%s/terraform.tfstate", path_relative_to_include())
    region         = local.aws_region
    dynamodb_table = "my-lock-table"
    # profile        = local.aws_profile
    }
}

terraform {
  after_hook "remove_lock" {
    commands = [
      "apply",
      "console",
      "destroy",
      "import",
      "init",
      "plan",
      "push",
      "refresh",
    ]

    execute = [
      "rm",
      "-f",
      "${get_terragrunt_dir()}/.terraform.lock.hcl",
    ]

    run_on_error = true
  }
}
