variable "iam_role_ec2_arn" {
  type = string
}

variable "autoscaling_group" {
  type = string
}

variable "lb_target_group_name" {
  type = string
}

variable "s3_codepipeline" {
  type = string
}

variable "s3_codepipeline_arn" {
  type = string
}
