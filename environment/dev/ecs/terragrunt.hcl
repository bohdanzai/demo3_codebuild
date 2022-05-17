terraform {
  # source = "/home/bohdan/Dev_ops/demo3_tg/modules//ecs"
  source = "../../../modules//ecs"
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
