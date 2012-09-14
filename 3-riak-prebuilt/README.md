## Start Riak
* vagrant up
* vagrant ssh
* riak1 start
* riak2 start
* riak3 start

## Test Riak
* riak1-admin test
* riak2-admin test
* riak3-admin test
* curl localhost:8091/stats
* curl localhost:8092/stats
* curl localhost:8093/stats
