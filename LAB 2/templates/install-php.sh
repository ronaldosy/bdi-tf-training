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

