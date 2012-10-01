#! /bin/bash

if [ ! -d /home/vagrant/hbase-0.94.1 ]
then
  echo "Installing pre-requisites"
  apt-get -qq update
  apt-get -qq -y install openjdk-7-jdk
  echo "export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-i386/" >> /home/vagrant/.profile

  echo "Installing HBase"
  tar xfz /vagrant/hbase-0.94.1.tar.gz
  chown -hR vagrant.vagrant hbase-0.94.1

  echo "export HBASE_HOME=/home/vagrant/hbase-0.94.1" >> /home/vagrant/.profile
  cp /vagrant/hbase-site.xml /home/vagrant/hbase-0.94.1/conf 
  sed -e '2 s/127.0.1.1/127.0.0.1/' -i /etc/hosts

  echo "Done!"
else
  echo "HBase appears to be setup already!"
fi
