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
sudo apt-get install -y mysql-client #libmysqlclient-dev libmysqld-dev # this probably renders the line above redundant
#sudo cp /tmp/shared/modules/mysql/files/{install_mysql.sh,mysql-server_5.7.15-1ubuntu14.04_amd64.deb-bundle.tar} /opt/
#sudo mv /opt/mysql-server_5.7.15-1ubuntu14.04_amd64.deb-bundle.tar /opt/mysql.tar
#sudo ./install_mysql.sh

# create zabbix database
sudo cp /tmp/shared/setupDatabase.sql /opt/
sudo mysql -uroot -pvagrant < setupDatabase.sql
cd zabbix-3.2.1/database/mysql/
sudo mysql -uzabbix -pvagrant zabbix < schema.sql
sudo mysql -uzabbix -pvagrant zabbix < images.sql
sudo mysql -uzabbix -pvagrant zabbix < data.sql

# configure sources
cd ../..
sudo ./configure --enable-server --with-mysql #--with-net-snmp --with-libcurl --with-libxml2

# install everything
sudo make install

# edit config files

# start server daemon
zabbix_server

# might need to do some stuff with the PHP frontend here?

echo "Zabbix Server installed"