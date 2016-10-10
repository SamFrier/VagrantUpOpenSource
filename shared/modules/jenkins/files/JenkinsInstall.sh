#!/usr/bin/env bash
cd /opt
sudo dpkg -i jenkins_2.1_all.deb
sudo apt-get -f install -y
sudo dpkg -i jenkins_2.1_all.deb