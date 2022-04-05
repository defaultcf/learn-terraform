variable "vpc" {
  type = string
}

variable "private_1" {
  type = string
}

variable "private_2" {
  type = string
}

variable "public_1" {
  type = string
}

variable "public_2" {
  type = string
}

variable "iam_instance_profile" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "alb_sg" {
  type = string
}

variable "app_server_sg" {
  type = string
}
