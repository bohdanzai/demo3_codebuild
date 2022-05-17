output "vpc_id" {
  value = aws_vpc.dev_vpc.id
}

output "environment" {
  value = var.environment
}

output "region" {
    value = var.region
}

output "app_name" {
    value = var.app_name
}

