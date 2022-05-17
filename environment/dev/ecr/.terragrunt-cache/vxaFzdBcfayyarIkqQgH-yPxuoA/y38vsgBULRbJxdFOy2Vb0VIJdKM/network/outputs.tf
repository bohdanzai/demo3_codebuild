output "vpc_id" {
  value = aws_vpc.dev_vpc.id
}

output "environment" {
  value = var.environment
}

output "aws_region" {
    value = var.aws_region
}

output "app_name" {
    value = var.app_name
}

output "subnets" {
  # value = aws_subnet.private.*.id
  # value = aws_subnet.publicsubnet.*.id
  # value = aws_subnet.publicsubnet.*.index
  value = [for v in aws_subnet.publicsubnet : v.id]
}