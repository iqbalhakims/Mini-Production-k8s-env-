variable "aws_region" {
  default = "ap-southeast-1"
}

variable "instance_type" {
  default = "t3.medium"
}

variable "key_name" {
  description = "Existing AWS keypair"
}

variable "ami" {
  default = "ami-0df7a207adb9748c7" # Ubuntu 22.04 (update if needed)
}