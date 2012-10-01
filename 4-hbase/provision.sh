#! /bin/bash

set -ex

if [ ! -d /home/vagrant/hbase-0.94.1 ]
then
  echo "Installing pre-requisites"
  apt-get -qq update
  apt-get -qq -y install openjdk-7-jdk curl
  echo "export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-i386/" >> /home/vagrant/.profile

  echo "Installing HBase"
  tar xfz /vagrant/hbase-0.94.1.tar.gz
  chown -hR vagrant.vagrant hbase-0.94.1

  echo "export HBASE_HOME=/home/vagrant/hbase-0.94.1" >> /home/vagrant/.profile
  echo "export PATH=$PATH:${HBASE_HOME}/bin" >> /home/vagrant/.profile
  cp /vagrant/hbase-site.xml /home/vagrant/hbase-0.94.1/conf 
  sed -e '2 s/127.0.1.1/127.0.0.1/' -i /etc/hosts

  echo "Installing Thrift for Day 3"
  apt-get install -y libboost-dev libboost-test-dev libboost-program-options-dev libevent-dev automake libtool flex bison pkg-config g++ libssl-dev make
  cd ~vagrant
  wget https://dist.apache.org/repos/dist/release/thrift/0.8.0/thrift-0.8.0.tar.gz
  tar zxvf thrift-0.8.0.tar.gz
  cd thrift-0.8.0
  ./configure
  make
  make install
  gem install thrift

  echo "Done!"
else
  echo "HBase appears to be setup already!"
fi
