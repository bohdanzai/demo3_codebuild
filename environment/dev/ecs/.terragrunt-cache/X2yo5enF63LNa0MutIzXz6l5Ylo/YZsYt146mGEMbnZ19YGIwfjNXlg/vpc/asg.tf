data "aws_ami" "aws_optimized_ecs" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn-ami*amazon-ecs-optimized"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["591542846629"] # AWS
}

resource "aws_launch_configuration" "webserver-launch-config" {
  name_prefix = "webserver-launch-config"
  image_id        = data.aws_ami.aws_optimized_ecs.id
  instance_type   = var.instance_type
  security_groups = [aws_security_group.mainSG.id]
  iam_instance_profile = aws_iam_instance_profile.ecs.name
  lifecycle {
    create_before_destroy = true
  }
  user_data = <<-EOF
		#!/bin/bash
    echo 'ECS_CLUSTER=demo3-dev-cluster' >> /etc/ecs/ecs.config
	EOF
}

resource "aws_autoscaling_group" "Demo-ASG-tf" {
  name = "${var.app_name}-${var.environment}-ASG"
  desired_capacity     = 2
  max_size             = 3
  min_size             = 2
  force_delete         = true
  target_group_arns    = ["${aws_alb_target_group.app.arn}"]
  health_check_type    = "EC2"
  launch_configuration = aws_launch_configuration.webserver-launch-config.name
  vpc_zone_identifier  = [for subnet in aws_subnet.publicsubnet : subnet.id]

  tag {
    key                 = "Name"
    value               = "${var.app_name}-${var.environment}-ASG"
    propagate_at_launch = true
  }
}
