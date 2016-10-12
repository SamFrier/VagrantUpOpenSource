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
sudo apt-get install -y mysql-client

# create zabbix database
sudo cp /tmp/shared/setupDatabase.sql /opt/
sudo mysql -u root < setupDatabase.sql
cd zabbix-3.2.1/database/mysql/
sudo mysql -u zabbix zabbix < schema.sql
sudo mysql -u zabbix zabbix < images.sql
sudo mysql -u zabbix zabbix < data.sql

# configure sources
cd ../..
sudo ./configure --enable-server --with-mysql

# install everything
sudo make install

# edit config files


# start server daemon
zabbix_server

# might need to do some stuff with the PHP frontend here?

echo "Zabbix Server installed."
