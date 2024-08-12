# LAB 4
## Step-by-Step guide

1. Create the following file
    -  main.tf
    -  outputs.tf
    -  terraform.auto.tfvars
    -  variables.tf
    -  vpc.tf
2. Copy the following line into __terraform.auto.tfvars__
    ```
    region          = ""
    vpc_name        = ""
    vpc_cidr        = "10.0.0.0/16"
    azs             = []
    private_subnets = []
    public_subnets  = []
    db_subnets      = []
    ```
3. Fill the variable value inside __terraform.auto.tfvars__
4. Run
    - terraform init
    - terraform plan
    - terraform apply