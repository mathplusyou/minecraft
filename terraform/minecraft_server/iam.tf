#############
# IAM Policy Documents 
#############

data aws_iam_policy_document ec2_assume_role {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

#############
# IAM Roles
#############

resource aws_iam_role minecraft {
  name_prefix = "${var.env}-minecraft-server"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}

##############
# IAM Instance Profiles
##############

resource aws_iam_instance_profile minecraft {
  name_prefix = "${var.env}-minecraft-server"
  role = aws_iam_role.minecraft.name
}
