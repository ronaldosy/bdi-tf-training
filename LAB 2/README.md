# LAB 2 
## Step-By-Step guide

1. Create the following files 
    - alb.tf
    - ec2.tf
    - main.tf
    - rds.tf
    - security-groups.tf
    - terraform.auto.tfvars
    - user-data.tf
    - variables.tf
    - vpc.tf
2. Create templates folder 
3. Inside template folder create file install-php.sh
4. Copy the following code into __install-php.sh__
    ```
    #!/bin/bash
    exec > /tmp/user_data.log 2>&1
    set -x 

    sudo apt-get -y update
    sudo apt install -y apache2
    sudo apt install -y php
    sudo touch /var/www/html/hostname.php
    cat << EOF | sudo tee /var/www/html/hostname.php
    <?php
    echo gethostname();
    ?>
    EOF 
    ```
5. Copy the following line into __terraform.auto.tfvars__
    ```
    region          = ""
    vpc_name        = ""
    vpc_cidr        = ""
    azs             = []
    private_subnets = []
    public_subnets  = []
    db_subnets      = []
    ec2 = {
    instance_type = ""
    ami_id        = "a"
    }
    rds_instance_type = ""
    ```
6. Fill the variable value inside __terraform.auto.tfvars__
7. Run
    - terraform init
    - terraform plan
    - terraform apply