terraform {
  source = "/home/bohdan/Dev_ops/demo3_tg/modules//network"
}


include {
  path = find_in_parent_folders()
}

# terraform {
#   source = "../../../../modules//vpc"
# }

# dependency "vpc" {
#     config_path = "../../modules//vpc"
# }

# include "root"{
#   path = find_in_parent_folders()
# }

