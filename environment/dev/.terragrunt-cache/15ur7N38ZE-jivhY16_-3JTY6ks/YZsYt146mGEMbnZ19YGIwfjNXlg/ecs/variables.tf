# variable "environment" {}

variable "environment" {
  default = "dev"
}

variable "region" {
  type    = string
  default = "us-east-2"
}

# variable "app_name" {}

variable "app_name" {
    type = string
    default = "demo3"
}

variable "ecs_task_role_name" {
  default = "TaskRole"
}

variable "ecs_task_execution_role_name" {
  default = "TaskExRole"
}

variable "task_cpu" {
  default = "1 vCPU"
}

variable "task_ram" {
  default = "0.5GB"
}

variable "container_cpu" {
  type = number
  default = 256
}

variable "container_ram" {
  type = number
  default = 256
}

variable "service_desired_count" {
  default = 2
}

variable "container_port" {
  type = number
  default = 80
}

variable "host_port" {
  type = number
  default = 80
}

# variable "ecr_repository_url" {}

# variable "image_tag" {}

variable "ecr_repository_url" {
  type = string
  default = "873432059572.dkr.ecr.us-east-2.amazonaws.com"
}

variable "image_tag" {
  type = string
  default = "v1"
}