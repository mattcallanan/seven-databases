# Chapter 4 - HBase

This is the VM for chapter 4. On first boot it will provision Java for you and unpack the HBase archive.

To boot the VM image, cd into this folder and type `vagrant up`.

When the VM is ready you can type `vagrant ssh` to connect to it. 

**Note:** There is a bug in Vagrant v1.0.4 and earlier which sometimes prevents the provisioning process from completing cleanly. If you can see `Done!` in the output then you can press Ctrl+C twice to exit the process, then type `vagrant ssh`.

# CHAPTER 4 HBase - Commands

## Day 1
```
$ start-hbase.sh
$ jps
# Expect something like:
    # 16405 Jps
    # 16256 HMaster
$ hbase shell
hbase> version 
hbase> help 
hbase> status   
hbase> create 'wiki', 'text'    
hbase> put 'wiki', 'Home', 'text:', 'Welcome to the wiki!' 
hbase> get 'wiki', 'Home', 'text:'    
hbase> disable 'wiki' 
hbase> alter 'wiki', { NAME => 'text', VERSIONS => org.apache.hadoop.hbase.HConstants::ALL_VERSIONS } 
hbase> alter 'wiki', { NAME => 'revision', VERSIONS => org.apache.hadoop.hbase.HConstants::ALL_VERSIONS }
hbase> enable 'wiki' 

# Download http://media.pragprog.com/titles/rwdata/code/hbase/put_multiple_columns.rb to /vagrant_data

$ hbase shell /vagrant_data/put_multiple_columns.rb
hbase> get 'wiki', 'Home' 
```

## Day 2

```
hbase> disable 'wiki' 
hbase> alter 'wiki', {NAME=>'text', COMPRESSION=>'GZ', BLOOMFILTER=>'ROW'} 
hbase> enable 'wiki' 

# Restart hbase
$ stop-hbase.sh
$ start-hbase.sh

# Download http://media.pragprog.com/titles/rwdata/code/hbase/import_from_wikipedia.rb to /vagrant_data

$ curl http://dumps.wikimedia.org/enwiki/latest/enwiki-latest-pages-articles.xml.bz2 | bzcat | ${HBASE_HOME}/bin/hbase shell /vagrant_data/import_from_wikipedia.rb 
hbase> scan '.META.', { COLUMNS => [ 'info:server', 'info:regioninfo' ] } 
hbase> scan '-ROOT-', { COLUMNS => [ 'info:server', 'info:regioninfo' ] } 
hbase> describe 'wiki' 
hbase> describe '.META.' 
hbase> describe '-ROOT-' 
hbase> create 'links', { NAME => 'to', VERSIONS => 1, BLOOMFILTER => 'ROWCOL' },{ NAME => 'from', VERSIONS => 1, BLOOMFILTER => 'ROWCOL' } 
# Download http://media.pragprog.com/titles/rwdata/code/hbase/generate_wiki_links.rb to /vagrant_data
$ hbase shell /vagrant_data/generate_wiki_links.rb 
hbase> scan 'links', STARTROW => "Admiral Ackbar", ENDROW => "It's a Trap!" 
hbase> get 'links', 'Star Wars' 
hbase> count 'wiki', INTERVAL => 100000, CACHE => 10000 
```

## Day 3

```
$ hbase-daemon.sh start thrift -threadpool -b 127.0.0.1 
$ jps
# Expect something like:
    # 1563 ThriftServer
    # 1314 HMaster
    # 1606 Jps
$ thrift -version     # should see 
$ RUBYOPT="rubygems" ruby -e "require 'thrift'"      # should see nothing
$ thrift --gen rb ${HBASE_HOME}/src/main/resources/org/apache/hadoop/hbase/thrift/Hbase.thrift

# Download http://media.pragprog.com/titles/rwdata/code/hbase/thrift_example.rb to /vagrant_data

$ RUBYOPT="rubygems" ruby /vagrant_data/thrift_example.rb 
$ wget http://mirror.mel.bkb.net.au/pub/apache/whirr/stable/whirr-0.8.0.tar.gz
$ bin/whirr version Apache Whirr 0.6.0-incubating 
$ mkdir keys 
$ ssh-keygen -t rsa -P '' -f keys/id_rsa

# Download and edit http://media.pragprog.com/titles/rwdata/code/hbase/hbase.properties to /vagrant_data

$ whirr launch-cluster --config /vagrant_data/hbase.properties 
$ ssh -i keys/id_rsa ${USER}@<SERVER_NAME> 
hbase> status 6 servers, 0 dead, 2.0000 average load
$ whirr destroy-cluster --config hbase.properties 
$ sudo /usr/local/hbase-0.90.3/bin/hbase-daemon.sh start thrift -b 0.0.0.0
```
