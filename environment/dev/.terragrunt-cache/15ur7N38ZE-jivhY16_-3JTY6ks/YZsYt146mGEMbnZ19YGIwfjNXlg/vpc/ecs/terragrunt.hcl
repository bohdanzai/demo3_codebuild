terraform {
  source = "/home/bohdan/Dev_ops/terragrunt_vpc/modules//ecs"
}

# include "root" {
#   path = find_in_parent_folders()
# }

# dependency "vpc" {
#     config_path = "../../modules//vpc"
# }

include "root"{
  path = find_in_parent_folders()
}
