#!/bin/bash
#
# [Quick LEMP install Server Script]
#
# GitHub:   https://github.com/soninod/quick-lemp-install
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
sudo apt-get -y install php php7.2-fpm php7.2-mysql

#Move nginx conf file to enable php support on ngnix
echo -e "\nMoving Nginx configuration file...\n"
sudo mv default /etc/nginx/sites-available

sudo systemctl restart nginx.service

echo -e "\n\nLemp stack installed successfully :)\n"
