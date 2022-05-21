variable "region" {
  type    = string
  default = "us-east-2"
}

# variable "vpc_name" {
#   type    = string
#   default = "dev_vpc"
# }

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "protocol" {
  default = "tcp"
}

variable "cidr" {
  default = "10.0.0.0/16"
}

variable "allowed_cidr" {
  type = list(string)
  default = ["0.0.0.0/0"]
}

variable "route_cidr" {
  default = "0.0.0.0/0"
}

variable "publicSubnetCIDR" {
  type = list(string)
  default = ["10.0.1.0/24","10.0.2.0/24"]
}

# variable "privateSubnetCIDR" {
#   type = list(string)
#   default = ["10.0.10.0/24","10.0.20.0/24"]
# }

variable "allowed_ports" {
  description = "List of allowed ports"
  type = list(any)
  default = ["80","8080","443","22"]
}

variable "alb_ports" {
  description = "List of allowed ports"
  type = list(any)
  default = ["80"]
}

variable "app_name" {
    type = string
    default = "demo3"
}

variable "environment" {
  default = "dev"
}

variable "app_port" {
  type = string
  default = 80
}

variable "host_port" {
    type = string
  default = 80
}

