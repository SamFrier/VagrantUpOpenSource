#!/bin/bash

SITE='/etc/puppet/manifests'
echo "Setting up Master"

shared='/tmp/shared'

sudo cp $shared/jira.bin $shared/modules/jira/files
sudo cp $shared/java.tar.gz $shared/modules/java/files
sudo cp $shared/jenkins_2.1_all.deb $shared/modules/jenkins/files
sudo cp $shared/mysql-server_5.7.15-1ubuntu14.04_amd64.deb-bundle.tar $shared/modules/mysql/files
sudo cp $shared/nexus-3.0.2-02-unix.tar.gz $shared/modules/nexus/files
sudo cp $shared/maven.tar.gz $shared/modules/maven/files
sudo cp $shared/atlassian-bamboo-5.13.2.tar.gz $shared/modules/bamboo/files
sudo cp $shared/zabbix-3.2.1.tar.gz $shared/modules/zabbix/files

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
sudo cp /tmp/shared/installZabbixServer.sh /opt/
sudo cp /tmp/shared/zabbix-3.2.1.tar.gz /opt/
cd /opt/
sudo dos2unix *.sh
sudo ./installZabbixServer.sh

sudo ifdown eth1
sudo ifup eth1
sudo ifconfig eth1 192.168.1.20
nohup firefox -new-window 'http://vumaster.qac.local/zabbix'
