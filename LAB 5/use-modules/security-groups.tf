module "web_sg" {
    source = "git::https://github.com/ronaldosy/tf-module-tutorial.git?ref=v1.0.0"
    sg_name = "allow_web_from_internet"
    sg_description = "Allow Web Access from Internet"
    vpc_id = module.vpc.vpc_id
    cidr_block = ["0.0.0.0/0"]
}