variable "environment" {
  description = "Name of the environment"
  type        = string
}

variable "ec2_ami" {
  description = "AMI for the minecraft instance"
  type        = string
}

variable "ec2_root_vol_size" {
  description = "EC2 root volume size of the minecraft instance"
  type        = string
  default     = "50"
}

variable "ec2_instance_type" {
  description = "Instance type for the minecract EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "public_key" {
  description = "Public key used to ssh onto the instance. An aws key pair will be created from the this public key."
  type        = string
}
