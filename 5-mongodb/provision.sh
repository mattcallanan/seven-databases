#! /bin/bash

set -ex

if [ ! -f /usr/bin/mongo ]
then
  echo "Installing MongoDB"
  apt-get update
  apt-get -y install mongodb

  sed -e '11 s/127.0.0.1/0.0.0.0/' -i /etc/mongodb.conf
  /etc/init.d/mongodb restart
  echo "Done!"
else
  echo "MongoDB appears to be setup already!"
fi
