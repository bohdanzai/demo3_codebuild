terraform {
  source = "../../../modules//codebuild"
}

include {
  path = find_in_parent_folders()
}

locals {
  secrets = read_terragrunt_config(find_in_parent_folders("secrets.hcl"))
}

dependency "ecr" {
  config_path = "../ecr"
  skip_outputs = true
}

dependency "network" {
  config_path = "../network"
  mock_outputs = {
    vpc_id          = "vpc-000000000000"
    subnets = ["subnet-00000000000", "subnet-111111111111"]
  }
}

inputs = merge(
  local.secrets.inputs,
  {
    vpc_id = dependency.network.outputs.vpc_id
    subnets = dependency.network.outputs.subnets
    build_spec_file = "providers/dev/buildspec.yml"
  }
)
