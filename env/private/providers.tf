terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.8"
    }
  }
  backend "s3" {
    bucket = "tf-example-private"
    key = "terraform.tfstate"
    region = "us-east-1"
  }
  required_version = ">= 1.1.7"
}

provider "aws" {
  region = "us-east-1"
}
