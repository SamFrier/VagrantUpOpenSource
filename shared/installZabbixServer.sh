#!/bin/bash

echo "Installing Zabbix Server"

# unzip zabbix server files
cd /opt/
sudo tar zxf zabbix-3.2.1.tar.gz

# create user account
sudo groupadd zabbix
sudo useradd -g zabbix zabbix

# install mysql on master
sudo puppet apply /etc/puppet/modules/mysql/tests/init.pp

# create zabbix database
sudo cp /tmp/shared/setupDatabase.sql /opt/
sudo mysql -u root < setupDatabase.sql
cd zabbix-3.2.1/database/mysql/
sudo mysql -u zabbix -pvagrantup zabbix < schema.sql
sudo mysql -u zabbix -pvagrantup zabbix < images.sql
sudo mysql -u zabbix -pvagrantup zabbix < data.sql

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
sudo apt-get install -y php5-mysql php5-gd

sudo a2dissite 000-default.conf
sudo service apache2 reload
sudo apt-get install -y php5

# setup web-based frontend
sudo mkdir /var/www/zabbix
cd frontends/php
sudo cp -a . /var/www/zabbix

sudo sed -i 's/max_size = 8/max_size = 16/g' /etc/php5/apache2/php.ini
sudo sed -i 's/on_time = 30/on_time = 300/g' /etc/php5/apache2/php.ini
sudo sed -i 's/max_input_time = 60/max_input_time = 300/g' /etc/php5/apache2/php.ini
sudo sed -i 's/;date.timezone =/date.timezone = UTC/g' /etc/php5/apache2/php.ini

sudo cp /tmp/shared/zabbix.conf.php /var/www/zabbix/conf/

sudo service apache2 restart

echo "Zabbix Server installed. Visit http://<server_ip>/zabbix to complete setup."
