terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.61.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-3"
}

resource "aws_instance" "web" {
  ami           = "ami-010917f061ff4bc09"
  instance_type = "t3.micro"

  tags = {
    Name = "Web Server-${terraform.workspace}"
    Env = "${terraform.workspace}"
  }
}