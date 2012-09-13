# From: http://wiki.basho.com/Installing-on-Debian-and-Ubuntu.html

# Update the package info and install the pre-requisites for building Erlang and Riak
apt-get -qq update
apt-get -qq -y install libssl0.9.8 build-essential libc6-dev git curl

# Install kerl
mkdir -p /opt/kerl
cd /opt/kerl
cp /vagrant/kerl .
chown vagrant.vagrant kerl
chmod a+x kerl
cp -R /vagrant/.kerl .

# Install Erlang
./kerl build R15B01 r15b01
./kerl install r15b01 /home/vagrant/erlang/r15b01
. /home/vagrant/erlang/r15b01/activate
echo . /home/vagrant/erlang/r15b01/activate >> /home/vagrant/.profile 

# Install Riak
cd /opt
cp /vagrant/riak-1.2.0.tar.gz .
tar zxf riak-1.2.0.tar.gz
cd riak-1.2.0
make rel
make devrel
cd ..
chown -hR vagrant.vagrant riak-1.2.0 

# Setup aliases for the 3 Riak instance scripts
cat >> ~vagrant/.bashrc << EOF
alias riak1='/opt/riak-1.2.0/dev/dev1/bin/riak'
alias riak2='/opt/riak-1.2.0/dev/dev2/bin/riak'
alias riak3='/opt/riak-1.2.0/dev/dev3/bin/riak'
alias riak1-admin='/opt/riak-1.2.0/dev/dev1/bin/riak-admin'
alias riak2-admin='/opt/riak-1.2.0/dev/dev2/bin/riak-admin'
alias riak3-admin='/opt/riak-1.2.0/dev/dev3/bin/riak-admin'
EOF

# Done!
exit
