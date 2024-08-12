##################### Provider Configuration Section ##########################
# Define the region which the resource will be deployed
variable "region" {
  type    = string
 
  validation {
    condition     = can(regex("[a-z][a-z]-[a-z]+-[1-9]", var.region))
    error_message = "Must be valid AWS Region names."
  }
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
  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "Must be valid IPv4 CIDR."
  }
}

# Define which AZ will be used
variable "azs" {
  type = list(string)

  validation {
    condition     = alltrue([for az in var.azs : strcontains(az, var.region)])
    error_message = "Not a valid Avalaibility Zone"
  }
}

# Define the CIDR for public subnets, must be part of VPC CIDR
variable "public_subnets" {
  type = list(string)

  validation {
    condition = length(var.public_subnets) <= length(var.azs)
    error_message = "Number of subnet should be higher number of AZ"
  }
}

# Define the CIDR for private subnets, must be part for  VPC CIDR
variable "private_subnets" {
  type = list(string)

  validation {
    condition = length(var.private_subnets) <= length(var.azs)
    error_message = "Number of subnet should be higher number of AZ"
  }
}

variable "db_subnets" {
  type = list(string)

  validation {
    condition = length(var.db_subnets) <= length(var.azs)
    error_message = "Number of subnet should be higher number of AZ"
  }
}
############################ End VPC Related Variables ###################


