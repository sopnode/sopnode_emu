# Instructions

This page covers how to start and setup a software emulator of an sdn enabled network managed by onos and composed of stratum switches using `vagrant` and `virtualbox`.

First we need to install vagrant and virtualbox, which will be our tool to setup our developper envirenement and maange Vms.

## Virtualbox installation
On Linux (such as Fedora)

    Download .run file for linux-64bit from https://www.virtualbox.org/wiki/Testbuilds then execute the downloaded file (e.g., sh <linux-64bit file>.run).
    
To verify that virtualbox is installed correctly, use this command :

```console
vboxmanage --version
```
On Windows and MacOS

    Follow instructions on https://www.virtualbox.org/manual/ch02.html

## Vagarant Installation

From the website below, download and install the appropriate version of vagrant depending on your OS.

[https://www.vagrantup.com/downloads](https://www.vagrantup.com/downloads)

### Download the emulator image
Vagrant will automatically search for the box and download it on your first ``` vagrant up``` command, but you can also download the box manually if you wish to.

If you want to download the box manually, go to the link below and download the box : 

[https://drive.google.com/file/d/1VPkwNMBCsAQGExh3tPbdm2kCm83CoSwn/view?usp=sharing](https://drive.google.com/file/d/1VPkwNMBCsAQGExh3tPbdm2kCm83CoSwn/view?usp=sharing)

after downloading the box you can add it to vagrant with this commad: 

```console
vagrant box add [Path to the downloaded box] --name lahsini/sopnode --force
```

verify that the box is added correctly by typing the command. You should see the box named "lahsini/sopnode" listed with the available boxes.

```console
vagrant box list
```

### Basic vagrant commands
To verify that vagrant is installed correctly, use this command
```console
vagrant -v
```
From within the directory where the Vagrant file is located:

to create, start, and configure guest machines according to your Vagrantfile
```console
vagrant up
```
to connect via SSH to a running Vagrant machine and get shell access.

```console
vagrant ssh
```

to shut down a running machine Vagrant is managing.
```console
vagrant halt
```

the equivalent of running a halt followed by an up.
```console
vagrant reload
```

list all the boxes that are installed into Vagrant.
```console
vagrant box list
```

remove a box from Vagrant that matches the given name.
```console
vagrant box remove <NAME>
```

## Start the environment - Vagrant setup

```console
git clone https://github.com/sopnode/sopnode_emu.git sopnode_emu
cd sopnode_emu
```

All of these commands can take several minutes to finish specially if you dont have the image downloaded.

- To start the first switch (`sw1`):
```console
cd switch1
vagrant up
cd ..
```
- To start the second switch (`sw2`):
```console
cd switch2
vagrant up
cd ..
```

- To start the second switch (`sw3`):
```console
cd switch3
vagrant up
cd ..
```
Above commands start 3 vms with `bmv2` software switch already installed on them.

We also provide a pre setup box with `Ansible` that can be used to manipulate the switches.

```console
cd AnsibleController
vagrant up
```
Now you have all your environment setup. To obtain a console on a switch, go in the directory where its Vagrantfile is defined and run the command `vagrant ssh`. It is worth noting that this particular directory is mounted in the `/vagrant` directory on the switch.
