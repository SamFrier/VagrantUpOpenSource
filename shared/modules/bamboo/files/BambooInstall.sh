#!/usr/bin/env bash
cd /opt
sudo tar zxvf atlassian-bamboo-5.13.2.tar.gz
sudo mkdir /home/vagrant/Desktop/bamboo-home
sudo sed -i '1ibamboo.home= /home/vagrant/Desktop/bamboo-home\' /opt/atlassian-bamboo-5.13.2/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties
cd /opt/atlassian-bamboo-5.13.2
sudo bin/start-bamboo.sh

