#!/bin/bash

SITE='/etc/puppet/manifests'
echo "Setting up Master"

sudo apt-get -y update
sudo apt-get install -y openssh-server openssh-client
sudo apt-get install -y dos2unix
sudo ufw disable

#Install puppet
sudo apt-get install -y puppet puppetmaster
#Edit the hosts and conf files
echo "Editing hosts file..."
sed -i '1s/^/127.0.0.1	vumaster.qac.local	puppetmaster\n192.168.1.20	vumaster.qac.local	puppetmaster\n/' /etc/hosts
echo "Editing puppet.conf file..."
echo "autosign = true">>/etc/puppet/puppet.conf

#Add to site.pp
echo "Configuring site.pp..."
echo "node 'vuagent1.qac.local', 'vuagent2.qac.local', 'vuagent3.qac.local' {">>$SITE/site.pp
echo "	include jenkins">>$SITE/site.pp
echo "	include java">>$SITE/site.pp
echo "	include maven">>$SITE/site.pp
echo "	include git">>$SITE/site.pp
echo "	include jira">>$SITE/site.pp
echo "	include nexus">>$SITE/site.pp
echo "	include bamboo">>$SITE/site.pp
echo "	include mysql">>$SITE/site.pp
echo "	include zabbix">>$SITE/site.pp
echo "}">>$SITE/site.pp

#Copy over the necessary modules
sudo cp -r /tmp/shared/modules /etc/puppet

# make sure scripts have the proper line endings
sudo dos2unix /etc/puppet/modules/{bamboo,java,jenkins,maven,mysql,nexus,zabbix}/files/*.sh

# install zabbix server
sudo cp /tmp/shared/{zabbix-3.2.1.tar.gz,installZabbixServer.sh} /opt/
cd /opt/
sudo dos2unix installZabbixServer.sh
sudo ./installZabbixServer.sh
