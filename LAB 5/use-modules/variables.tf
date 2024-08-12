variable "region"{
    type = string
}

variable "vpc_name" {
  type = string
}

# Define the VPC CIDR
variable "vpc_cidr" {
  type = string
}

# Define which AZ will be used
variable "azs" {
  type = list(string)
}

# Define the CIDR for public subnets, must be part of VPC CIDR
variable "public_subnets" {
  type = list(string)
}

# Define the CIDR for private subnets, must be part for  VPC CIDR
variable "private_subnets" {
  type = list(string)
}

variable "db_subnets" {
  type = list(string)
}

variable "ec2" {
  type = map(string)
}