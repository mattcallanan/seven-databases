#! /bin/bash

set -ex

if [ ! -f /usr/bin/mongo ]
then
  echo "Installing MongoDB"
  apt-get -qq update
  apt-get -qq -y install mongodb

  echo "Done!"
else
  echo "MongoDB appears to be setup already!"
fi
