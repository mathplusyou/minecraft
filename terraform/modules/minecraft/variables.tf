variable env {
  description = "Name of the environment"
  type        = string
}

variable ec2_ami {
  description = "AMI for the minecraft instance"
  type        = string
}

variable ec2_root_vol_size {
  description = "EC2 root volume size of the minecraft instance"
  type        = string
  default     = "50"
}

variable ec2_instance_type {
  description = "Instance type for the minecract EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable minecraft_allowed_cidr_blocks {
  description = "List of IPs that are allowed to hit the minecraft srever"
  type = list(string)
}

variable minecraft_server_port {
  description = "Port that the minecraft server will serve on"
  type = number
  default = 25565
}

variable public_key {
  description = "Public key used to ssh onto the instance. An aws key pair will be created from the this public key."
  type        = string
}

variable ssh_cidr_blocks {
  description = "CIDR blocks allowed to connect to the minecraft instance over ssh"
  type = list(string)
}

variable vpc_id {
  description = "ID of the VPC that the minecraft instance wil be deployed in."
  type = string
}

variable public_subnets {
  description = "List of public subnets that the minecraft server ASG should be deployed to."
  type = list(string)
}
