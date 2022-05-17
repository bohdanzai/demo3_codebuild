# provider "aws" {
#   aws_region = module.network.aws_region
# }

module "network" {
  source = "./modules/network"
  host_port = module.ecs.host_port
}

module "ecr" {
    source = "./modules/ecr"
    environment = module.network.environment
    app_name = module.network.app_name
    aws_region = module.network.aws_region
}

module "ecs" {
    source = "./modules/ecs"
    environment = module.network.environment
    app_name = module.network.app_name
    ecr_repository_url = module.ecr.ecr_repository_url
    image_tag = module.ecr.image_tag
}