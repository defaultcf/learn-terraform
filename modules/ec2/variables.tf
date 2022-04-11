variable "region" {
  type = string
}

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

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "s3_codepipeline" {
  type = string
}

variable "s3_codepipeline_arn" {
  type = string
}
