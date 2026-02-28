variable "aws_region" {
  default = "ap-southeast-1"
}

variable "instance_type" {
  default = "t3.medium"
}

variable "key_name_controlplane" {
  default = "controlplane-k8s-key"
}

variable "key_name_workers" {
  default = "controlplane-k8s-key"
}


variable "ami" {
  default = "ami-0df7a207adb9748c7" # Ubuntu 22.04 (update if needed)
}