variable "ami_prefix" {
  type    = string
  default = "learn-packer-amazon-linux-httpd"
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "amazon-linux" {
  ami_name      = "${var.ami_prefix}-${local.timestamp}"
  instance_type = "t2.micro"
  region        = "us-east-1"
  ssh_username  = "ec2-user"

  source_ami_filter {
    filters = {
      name                = "amzn2-ami-hvm-*-x86_64-gp2"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["amazon"]
  }
}

build {
  name    = "learn-packer"
  sources = ["source.amazon-ebs.amazon-linux"]

  provisioner "ansible" {
    playbook_file = "playbook.yml"
  }
}
