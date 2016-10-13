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

# edit config file (not tested!!)
sudo sed 's/Server=\(.*\)\n/Server=192.168.1.20\n/g' /usr/local/etc/zabbix_agentd.conf

#test using zabbix_agentd -V
sudo zabbix_agentd