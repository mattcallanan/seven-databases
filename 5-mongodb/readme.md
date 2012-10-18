# Chapter 5 - MongoDB

This is the VM for chapter 5. On first boot it will provision Java for you and unpack the MongoDB archive.

To boot the VM image, cd into this folder and type `vagrant up`.

When the VM is ready you can type `vagrant ssh` to connect to it. 

**Note:** There is a bug in Vagrant v1.0.4 and earlier which sometimes prevents the provisioning process from completing cleanly. If you can see `Done!` in the output then you can press Ctrl+C twice to exit the process, then type `vagrant ssh`.
