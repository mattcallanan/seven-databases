#! /bin/bash

if [ ! -f /home/vagrant/riak-1.2.0/dev/dev1/bin/riak ]
then
  echo "Installing pre-requisites"
  apt-get -qq update
  apt-get -qq -y install libssl0.9.8 build-essential libc6-dev git curl

  echo "Installing kerl"
  cp /vagrant/kerl .
  chown vagrant.vagrant kerl
  chmod a+x kerl
  cp -R /vagrant/.kerl /root

  echo "Building Erlang"
  ./kerl build R15B01 r15b01
  ./kerl install r15b01 /home/vagrant/erlang/r15b01
  . /home/vagrant/erlang/r15b01/activate
  echo . /home/vagrant/erlang/r15b01/activate >> /home/vagrant/.profile 

  echo "Building Riak"
  cp /vagrant/riak-1.2.0.tar.gz .
  tar zxf riak-1.2.0.tar.gz
  cd riak-1.2.0
  make rel
  make devrel
  cd ..
  chown -hR vagrant.vagrant riak-1.2.0 
  
  echo "Done!"
else
  echo "Riak appears to be setup already!"
fi
