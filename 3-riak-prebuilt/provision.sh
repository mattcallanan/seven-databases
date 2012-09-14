apt-get -q update
apt-get -y install libssl0.9.8 git curl
cd /opt
tar zxvf /vagrant/riak-1.2.0-dev.tar.gz
chown -hR vagrant.vagrant riak-1.2.0 
cp /vagrant/.bashrc ~vagrant/
exit
