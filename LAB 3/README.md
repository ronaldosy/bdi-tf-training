# LAB 3
## Pre-Req
1. Create S3 bucket for terraform state location.
2. Inside the S3 bucket create folder with each participant name.
3. Inside each participant name folder create 3 folder vpc & ec2
3. Create dynamo table for lock file location.

## Step-By-Step guide
### VPC Creation 
1. Create VPC folder 
2. Go to vpc folder 
3. Create the following files
    - main.tf
    - outputs.tf
    - terraform.auto.tfvars
    - variables.tf
    - vpc.tf
4. Enter the necessary variable values in __terraform.auto.tfvars__
5. in the backend section inside the main.tf enter the value for:
    - `bucket = [bucket_name]`
    - `key = particpant_name/vpc/terraform.tfstate'
    - `dynamodb_table = [dynamo_table_name]`

### EC2 Creation
1. Create EC2 folder 
2. Go to EC2 folder
3. Create the following files
    - locals.tf
    - ec2.tf
    - main.tf
    - security-groups.tf
    - variables.tf
    - terraform.auto.tfvars
4. Enter the necessary variable values in __terraform.auto.tfvars__
5. in the backend section inside the main.tf enter the value for:
    - `bucket = [bucket_name]`
    - `key = particpant_name/ec2/terraform.tfstate`
    - `dynamodb_table = [dynamo_table_name]`