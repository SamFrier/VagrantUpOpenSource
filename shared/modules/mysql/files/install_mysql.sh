#!/bin/bash
cd /opt/
sudo tar xvf mysql.tar
export DEBIAN_FRONTEND="noninteractive"
sudo -E dpkg-preconfigure mysql-community-server_*.deb # NB: this currently sets no root password!
sudo dpkg -i {\
mysql-common,\
mysql-community-client,\
mysql-client,\
mysql-community-server,\
mysql-server,\
libmysqlclient20,\
libmysqlclient-dev,\
libmysqld-dev}_*.deb
sudo apt-get -f install -y
#sudo dpkg -i mysql-{common,community-client,client,community-server,server}_*.deb
sudo dpkg -i {\
mysql-common,\
mysql-community-client,\
mysql-client,\
mysql-community-server,\
mysql-server,\
libmysqlclient20,\
libmysqlclient-dev,\
libmysqld-dev}_*.deb