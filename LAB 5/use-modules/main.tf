terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.61.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true
  single_nat_gateway = false

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

resource "aws_instance" "test_instances" {
  instance_type               = var.ec2["instance_type"]
  ami                         = var.ec2["ami_id"]
  key_name                    = "ronaldo-key"
  associate_public_ip_address = false
  # user_data                   = data.template_file.php-install.rendered
  # subnet_id                   = count.index % 2 == 0 ? aws_subnet.private_subnet[0].id : aws_subnet.private_subnet[1].id
  subnet_id = module.vpc.public_subnets[0]
  vpc_security_group_ids      = [module.web_sg.sg_id]
  root_block_device {
    delete_on_termination = "true"
    volume_size           = "10"
    volume_type           = "gp3"
    iops                  = "3000"
    throughput            = "125"
  }

  tags = {
    Name = "BDI Training EC2 Instance"
  }
}
