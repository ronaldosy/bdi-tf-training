locals {
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  public_subnet_id = data.terraform_remote_state.vpc.outputs.public_subnet_id
}