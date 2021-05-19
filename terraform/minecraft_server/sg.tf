resource "aws_security_group" "minecraft" {
  name_prefix = "minecraft-${var.env}"
  description = "allow inbound and outbound traffic to minecraft server"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "minecraft_ssh_ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.ssh_cidr_blocks]
  security_group_id = aws_security_group.minecraft.id

}

resource "aws_security_group_rule" "minecraft_default_ingress" {
  type              = "ingress"
  from_port         = var.minecraft_server_port
  to_port           = var.minecraft_server_port
  protocol          = "tcp"
  cidr_blocks       = [var.minecraft_allowed_cidr_blocks]
  security_group_id = aws_security_group.minecraft.id

}

resource "aws_security_group_rule" "minecraft_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.minecraft.id
}
