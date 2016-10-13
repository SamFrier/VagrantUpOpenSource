#!/bin/bash

echo "Installing Zabbix Server"

# unzip zabbix server files
cd /opt/
sudo tar zxvf zabbix-3.2.1.tar.gz

# create user account
sudo groupadd zabbix
sudo useradd -g zabbix zabbix

# install mysql on master
sudo puppet apply /etc/puppet/modules/mysql/tests/init.pp

# create zabbix database
sudo cp /tmp/shared/setupDatabase.sql /opt/
sudo mysql -u root < setupDatabase.sql
cd zabbix-3.2.1/database/mysql/
sudo mysql -u zabbix -p vagrantup zabbix < schema.sql
sudo mysql -u zabbix -p vagrantup zabbix < images.sql
sudo mysql -u zabbix -p vagrantup zabbix < data.sql

# configure sources
cd ../..
sudo ./configure --enable-server --with-mysql

# install everything
sudo make install

# edit config files
sudo sed -i 's/# DBPassword=/# DBPassword=\n\nDBPassword=vagrantup/g' /usr/local/etc/zabbix_server.conf

# start server daemon
sudo zabbix_server

# setup apache web server and php
sudo apt-get install -y apache2 apache2-doc apache2-utils
sudo sed -i 's/KeepAlive On/KeepAlive Off/g' /etc/apache2/apache2.conf
sudo a2dissite 000-default.conf
sudo service apache2 reload
sudo apt-get install -y php5

# setup web-based frontend
sudo mkdir /var/www/zabbix
cd frontends/php
sudo cp -a . /var/www/zabbix
sudo service apache2 restart

echo "Zabbix Server installed. Visit http://<server_ip>/zabbix to complete setup."
