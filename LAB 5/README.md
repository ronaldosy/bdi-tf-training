# LAB 5
## Step-by-Step guide

### Create Local Modules
1. Create the modules folder
2. Inside modules directory create security-grooup folder.
3. Inside security-group folder create the following files
    - main.tf
    - outputs.tf
    - variable.tf

### Create resource
1. inside the root folder create the following files 
    - main.tf
    - variables.tf
    - terraform.auto.tfvars
    - security-groups.tf
2. Copy the following line into __terraform.auto.tfvars__
    ```
    region = ""
    vpc_name = ""
    vpc_cidr = ""
    azs = []
    private_subnets = []
    public_subnets  = []
    db_subnets      = []
    ec2 = {
    instance_type = "t3.micro"
    ami_id        = "ami-010917f061ff4bc09"
}
    ```
3. Fill the variable value inside __terraform.auto.tfvars__
4. Run
    - terraform init
    - terraform plan
    - terraform apply