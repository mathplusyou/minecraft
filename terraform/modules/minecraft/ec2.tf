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

  launch_template {
    id = aws_launch_template.minecraft.id
  }
  vpc_zone_identifier = var.public_subnets

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

resource "aws_launch_template" "minecraft" {
  name_prefix   = "minecraft"
  image_id      = var.ec2_ami
  instance_type = var.ec2_instance_type
  iam_instance_profile {
    name = aws_iam_instance_profile.minecraft.name
  }
  key_name               = aws_key_pair.minecraft.key_name
  vpc_security_group_ids = [aws_security_group.minecraft.id]

  lifecycle {
    create_before_destroy = true
  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      delete_on_termination = "true"
      volume_size           = var.ec2_root_vol_size
      volume_type           = "gp2"
    }
  }

  dynamic "block_device_mappings" {
    for_each = var.ebs_block_devices
    content {
      device_name = ebs_block_devices.value.device_name
      ebs {
        delete_on_termination = lookup(ebs_block_devices.value, "delete_on_termination", null)
        encrypted             = lookup(ebs_block_devices.value, "encrypted", null)
        iops                  = lookup(ebs_block_devices.value, "iops", null)
        snapshot_id           = lookup(ebs_block_devices.value, "snapshot_id", null)
        volume_size           = lookup(ebs_block_devices.value, "volume_size", null)
        volume_type           = lookup(ebs_block_devices.value, "volume_type", null)
      }
    }
  }
}

resource "aws_key_pair" "minecraft" {
  key_name   = "minecraft_ssh"
  public_key = var.public_key
}
