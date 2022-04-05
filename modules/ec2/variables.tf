variable "subnet_id" {
  type = string
}

variable "iam_instance_profile" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}
