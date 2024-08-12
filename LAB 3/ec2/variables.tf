##################### Provider Configuration Section ##########################
# Define the region which the resource will be deployed
variable "region" {
  type    = string
  default = "ap-southeast-3"
}
################## End Provider Configuration Section ##################


################ EC2 Variables ##########################
# EC2 instance type
variable "ec2" {
  type = map(string)
}

################ End EC2 Variable #######################
