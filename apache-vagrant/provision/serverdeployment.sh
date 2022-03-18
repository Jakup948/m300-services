#!/usr/bin/env bash

echo "---UPDATING SERVER MACHINE---"
sudo apt-get -y update 

echo "---INSTALLING REQUIRED PACKAGES---"
sudo apt-get install apache2 apache2-utils -y

echo "---CONFIGURING THE FIREWALL---"
sudo ufw enable
sudo ufw allow 'Apache'
sudo ufw reload

echo "---CREATING FOLDER AND FILE WHICH ARE GOING TO BE BASIC AUTHENTICATION SECURED---"
sudo mkdir /var/www/html/protected
echo "Permission granted" >> /var/www/html/protected/index.html

echo "---CREATING USER AND PASSWORD FOR BASIC AUTHENTICATION ---"
sudo htpasswd -cb /etc/apache2/.htpasswd testuser password

echo "---CREATING AND EDITING THE APACHE CONFIG FILE---"
sudo cp /etc/apache2/sites-enabled/000-default.conf /etc/apache2/sites-enabled/000-default.conf.bak
sudo rm -f /etc/apache2/sites-enabled/000-default.conf
sudo tee -a /etc/apache2/sites-enabled/000-default.conf <<EOF
<Location /protected>
        AuthType Basic
        AuthName "Restricted Content"
        AuthUserFile /etc/apache2/.htpasswd
        Require valid-user
</Location>
EOF

echo "---CHECKING THE CONFIG FILE FOR ERRORS AND RESTARTING THE SERVICE ---"
sudo apachectl configtest
sudo service apache2 restart