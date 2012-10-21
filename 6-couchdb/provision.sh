#! /bin/bash

set -ex

export PS4="[provision.sh] "
if [ ! -f /usr/bin/couchdb ]
then
  echo "Installing CouchDB"
  apt-get -y update
  apt-get -y install couchdb
  apt-get -y install curl

  # Install Ruby
  apt-get install -y make
  apt-get install -y imagemagick
  apt-get install -y git
  apt-get install -y libxml2
  apt-get install -y libxml2-dev
  apt-get install -y libxslt1-dev
  apt-get install -y libsqlite3-dev
  apt-get install -y libmysql++-dev
  apt-get install -y ruby1.9.1 ruby1.9.1-dev
  gem install libxml-ruby couchrest

  # Install Node.js
  apt-get install -y python-software-properties
  add-apt-repository -y ppa:chris-lea/node.js
  apt-get update
  apt-get install -y nodejs npm
  
  sed -e 's/;bind_address = 127.0.0.1/bind_address = 0.0.0.0/' -i /etc/couchdb/local.ini
  /etc/init.d/couchdb restart
  echo "Done!"
else
  echo "Couch:wqDB appears to be setup already!"
fi

