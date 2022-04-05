variable "availability_zone" {
  type    = string
  default = "ap-northeast-1a"
}

variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "private_1_cidr_block" {
  type    = string
  default = "10.0.10.0/24"
}

variable "security_group_vpc_endpoint" {
  type = string
}
