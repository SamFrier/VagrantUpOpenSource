#!/usr/bin/env bash
cd /opt
sudo tar zxvf java.tar.gz
sudo update-alternatives --install /usr/bin/java java /opt/jdk1.8.0_45/bin/java 100
sudo update-alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_45/bin/javac 100
sudo update-alternatives --set java /opt/jdk1.8.0_45/bin/java
sudo update-alternatives --set javac /opt/jdk1.8.0_45/bin/javac

