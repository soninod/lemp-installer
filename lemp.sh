#!/bin/bash
#
# [Quick LEMP install Server Script]
#
# GitHub:   https://github.com/soninod/lemp-installer
# Author:   soninod
#


#updating packages
echo -e "\nUpdating package lists..\n"
sudo apt-get -y update && sudo apt-get upgrade

#install Ngnix
echo -e "\nInstalling Ngnix server...\n"
sudo apt-get -y install nginx


#install Mysql server
echo -e "\nInstalling Mysql server...\n"
#default password is root
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
sudo apt-get -y install mysql-server

#install Mysql server
echo -e "\nInstalling PHP-FPM and Mysql extension for PHP...\n"

# To install PHP 7.2 on Ubuntu 22.04, follow these steps:
# 
# Step 1: Add the Ondřej Surý PPA
# The default Ubuntu 22.04 repositories don't include PHP 7.2. You can use the repository provided by Ondřej Surý, which maintains older PHP versions.
# 
# First, update your package list:
# 
sudo apt update
# Install the required dependencies for adding a new repository:
# 
sudo apt install software-properties-common

# Add the Ondřej Surý PPA:
# 
sudo add-apt-repository ppa:ondrej/php

# Update your package list again:
# 
sudo apt update
# Step 2: Install PHP 7.2
# Now that the PPA is added, you can install PHP 7.2.
# 
# Install PHP 7.2:
# 
sudo apt install php7.2
# Verify the installation by checking the PHP version:
# 
php -v
# Step 3: Install Additional PHP 7.2 Modules (Optional)
# Depending on your application, you might need additional PHP modules. You can install them like this:
# 
sudo apt install php7.2-cli php7.2-fpm php7.2-mysql php7.2-xml php7.2-curl php7.2-mbstring php7.2-zip

# Step 4: Configure PHP (Optional)
# If you're using php-fpm, restart the service:
# 
sudo systemctl restart php7.2-fpm
# This will install PHP 7.2 on your Ubuntu 22.04 system.

sudo apt-get -y install php php7.2-fpm php7.2-mysql

#Move nginx conf file to enable php support on ngnix
echo -e "\nMoving Nginx configuration file...\n"
sudo mv default /etc/nginx/sites-available

sudo systemctl restart nginx.service

echo -e "\n\nLemp stack installed successfully :)\n"
