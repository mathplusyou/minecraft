resource "aws_autoscaling_group" "minecraft" {
  name_prefix               = "minecraft"
  max_size                  = 1
  min_size                  = 0
  desired_capacity          = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
  force_delete              = true

  lifecycle {
    create_before_destroy = true
  }

  launch_configuration = aws_launch_configuration.minecraft.name
  vpc_zone_identifier  = var.public_subnets

  tag {
    key                 = "environment"
    value               = var.env
    propagate_at_launch = "true"
  }
  tag {
    key                 = "Name"
    value               = "${var.env}-minecraft"
    propagate_at_launch = "true"
  }
  tag {
    key                 = "terraform"
    value               = "True"
    propagate_at_launch = "true"
  }
}

resource "aws_launch_configuration" "minecraft" {
  name_prefix          = "minecraft"
  image_id             = var.ec2_ami
  instance_type        = var.ec2_instance_type
  iam_instance_profile = aws_iam_instance_profile.minecraft.name
  key_name             = aws_key_pair.minecraft.key_name
  security_groups      = [aws_security_group.minecraft.id]

  lifecycle {
    create_before_destroy = true
  }

  root_block_device {
    delete_on_termination = "true"
    volume_size           = var.ec2_root_vol_size
    volume_type           = "gp2"
  }
}

resource "aws_key_pair" "minecraft" {
  key_name   = "minecraft_ssh"
  public_key = var.public_key
}
