variable "region" {
  type    = string
  default = "us-east-1"
}

variable "private_1_az" {
  type    = string
  default = "us-east-1a"
}

variable "private_2_az" {
  type    = string
  default = "us-east-1c"
}

variable "public_1_az" {
  type    = string
  default = "us-east-1a"
}

variable "public_2_az" {
  type    = string
  default = "us-east-1c"
}

variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "private_1_cidr_block" {
  type    = string
  default = "10.0.10.0/24"
}

variable "private_2_cidr_block" {
  type    = string
  default = "10.0.20.0/24"
}

variable "public_1_cidr_block" {
  type    = string
  default = "10.0.100.0/24"
}

variable "public_2_cidr_block" {
  type    = string
  default = "10.0.200.0/24"
}
