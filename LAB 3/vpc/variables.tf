##################### Provider Configuration Section ##########################
# Define the region which the resource will be deployed
variable "region" {
  type    = string
  default = "ap-southeast-3"
}
################## End Provider Configuration Section ##################

######################### VPC Related Variables ########################
# Define the VPC name
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
############################ End VPC Related Variables ###################


