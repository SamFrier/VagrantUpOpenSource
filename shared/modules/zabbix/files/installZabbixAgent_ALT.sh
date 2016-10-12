#!/usr/bin/env bash

# unzip zabbix agent files
cd /opt/
sudo tar zxvf zabbix-3.2.1.tar.gz

# create user account
sudo groupadd zabbix
sudo useradd -g zabbix zabbix

# don't need to worry about database

# configure sources
sudo ./configure --enable-agent

# install everything
sudo make install

# edit config files
# add database details??

# start server daemon
zabbix_agentd