terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.8"
    }
  }
  required_version = ">= 1.1.7"
}

provider "aws" {
  region = "ap-northeast-1"
}
