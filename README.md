# Instructions

This page covers how to start and setup a software emulator of an sdn enabled network mmanaged by onos and composed of stratum switches using vagrant and virtualbox.

First we need to install vagrant and virtualbox, which will be our tool to setup our developper envirenement and maange Vms.

## Virtualbox installation
On Linux (such as Fedora)

    Download .run file for linux-64bit from https://www.virtualbox.org/wiki/Testbuilds
    sh <linux-64bit file>.run
    To verify that virtualbox is installed correctly, use this command :

```console
vboxmanage --version
```
On Windows and MacOS

    Follow instructions on https://www.virtualbox.org/manual/ch02.html

## Vagarant Installation

From the website below, download and install the appropriate version of vagrant depending on your OS.

https://www.vagrantup.com/downloads

### Download the emulator image
Vagrant will automatically search for the box and download it on your first ``` vagrant up``` command, but you can also download the box manually if you wish to.

If you want to download the box manually, go to the link below and download the latest version of the box  (v1.1)

https://app.vagrantup.com/lahsini/boxes/sopnode/versions/1.1

after downloading the box you can add it to vagrant with this commad : 

``` vagrant box add [Path to the downloaded box] --name lahsini/sopnode --force ```

verify that the box is added correctly by typing the command. You should see the box named "lahsini/sopnode" listed with the available boxes.

```vagrant box list```

### Basic vagrant commands
to verify that vagrant is installed correctly, use this command
```console
vagrant -v
```
to start create and configures guest machines according to your Vagrantfile
```console
vagrant up
```
to SSH into a running Vagrant machine and get shell access.

```console
vagrant ssh
```
to shut down a running machine Vagrant is managing.
```console
vagrant halt
```
The equivalent of running a halt followed by an up.
```console
vagrant reload
```
list all the boxes that are installed into Vagrant.
```console
vagrant box list
```
remove a box from Vagrant that matches the given name.
```console
vagrant box remove NAME
```

## Start the environment - Vagrant setup

```console
git clone https://github.com/sopnode/sopnode_emu.git sopnode_emu
cd sopnode_emu
```

All of these commands can take several minutes to finish specially if you dont have the image downloaded.

- Start a terminal and type these commands to start the first switch(sw1).
```console
cd switch1
vagrant up
cd ..
```
- start a new terminal and type these commands to start the second switch(sw2) :
```console
cd switch2
vagrant up
cd ..
```

- start a new terminal and type these commands to start the second switch(sw3) :
```console
cd switch3
vagrant up
cd ..
```
Above commands start 3 vms with bmv2 software switch installed on them.

### Ansible controller

```console
cd AnsibleController
vagrant up
cd ..
```

Now you have all your envirenement setup, you can ssh to your switches by using ``` vagrant ssh```, all your files in your local eg:```/switch1 ``` directory will be mounted on ``` /vagrant``` directory on the host.