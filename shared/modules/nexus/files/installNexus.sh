#!/bin/bash

sudo tar -zxvf /opt/nexus-3.0.2-02-unix.tar.gz
sudo chmod 755 /opt/nexus-3.0.2-02/bin/nexus
cd /opt/nexus-3.0.2-02/bin
./nexus start &
