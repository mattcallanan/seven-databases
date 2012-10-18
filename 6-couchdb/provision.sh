#! /bin/bash

set -ex

if [ ! -f /usr/bin/couchdb ]
then
  echo "Installing CouchDB"
  apt-get -y update
  apt-get -y install couchdb

  sed -e 's/;bind_address = 127.0.0.1/bind_address = 0.0.0.0/' -i /etc/couchdb/local.ini
  /etc/init.d/couchdb restart
  echo "Done!"
else
  echo "Couch:wqDB appears to be setup already!"
fi