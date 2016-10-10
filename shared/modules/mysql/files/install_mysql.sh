#!/usr/bin/env bash

cd /opt/
sudo tar xvf mysql.tar
export DEBIAN_FRONTEND="noninteractive"
sudo -E dpkg-preconfigure mysql-community-server_*.deb # NB: this currently sets no root password!
sudo dpkg -i mysql-{common,community-client,client,community-server,server}_*.deb
sudo apt-get -f install -y
sudo dpkg -i mysql-{common,community-client,client,community-server,server}_*.deb
