# Chapter 3 - Riak

This is the VM for chapter 3. On first boot it will provision Erlang and Riak for you (from source) and build the Riak developer environment.

To boot the VM image, cd into this folder and type `vagrant up`.

When the VM is ready (which can take 20-30 minutes the first time) you can type `vagrant ssh` to connect to it. 

**Note:** There is a bug in Vagrant v1.0.4 and earlier which sometimes prevents the provisioning process from completing cleanly. If you can see `Done!` in the output then you can press Ctrl+C twice to exit the process, then type `vagrant ssh`.

Once you are connected via SSH you can cd into the `riak-1.2.0` folder and start launching Riak instances e.g. enter `dev/dev1/bin/riak start`
