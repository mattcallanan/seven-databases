This repository contains [Vagrant](http://vagrantup.com) configurations for each of the databases in the book [Seven Databases In Seven Weeks](http://pragprog.com/book/rwdata/seven-databases-in-seven-weeks). 

To use them, you will need to install both [VirtualBox](http://virtualbox.org) and [Vagrant](http://vagrantup.com). Once you have done that, you must either fork (if you want to share your solutions to the book exercises) or clone (if you don't want to share them) the repository. Then from the command, cd into the folder for the database/chapter you are working on and use the following commands:

* **vagrant up**: The first time you run this command (ever, or after running *vagrant destroy*), it will download the base image (if needed), launch the virtual machine, install the database and configure it to the point required at the start of the chapter. Subsequent executions will just start the virtual machine.
* **vagrant ssh**: Opens a SSH connection to the virtual machine.
* **vagrant halt**: Shuts down the virtual machine.
* **vagrant destroy**: Deletes the virtual machine image.

When the virtual machine is running, the folder from which it was started is shared between the host machine and the virtual machine (as */vagrant*). This means you can use your favourite tools in your host environment to edit the files in this folder and just use the SSH connection to issue any commands to the virtual machine (rather than editing with *vi* on the virtual machine).

For those that are interested, the base image used is just the Ubuntu 12.04 stock image supplied by Vagrant.