#!/usr/bin/env bash
#unzip 
cd /opt
sudo tar zxvf zabbix-3.2.1.tar.gz

#needs zabbix user
sudo groupadd zabbix
sudo useradd -g zabbix zabbix

cd zabbix-3.2.1
sudo ./configure --enable-agent

sudo make install
#test using zabbix_agentd -V
