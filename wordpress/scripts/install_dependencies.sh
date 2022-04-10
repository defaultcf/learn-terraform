#!/bin/bash

cd /var/www/html
/usr/local/bin/composer install

chown -R ec2-user:apache /var/www/html
chmod -R 775 /var/www/html
