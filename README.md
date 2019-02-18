# packer-esxi-ubuntu1804

## Description

This is a Packer template for installing an Ubuntu 18.04 (Bionic Beaver) server using a VMWare ESXi builder.

This template also uses Ansible to do some post configuration on the server. In its current form, the template will install Docker on the server by repeating the steps found in the installation guide: https://docs.docker.com/install/linux/docker-ce/ubuntu/ 

## Requirements

### On ESXi

Instead of using the web services API, Packer uses SSH to communicate and control ESXi. For this to work, you must enable SSH and create a firewall rule for VNC on the ESXi host.

Follow this guide to properly setup your ESXi server: https://nickcharlton.net/posts/using-packer-esxi-6.html 

Once configured, modify the variables.json file with your corresponding credentials for Packer to access ESXi.

### On your machine

You must have these installed on your machine. 

- Packer
- Ansible

## Preparation (What to modify before starting)

### variables.json

Copy this file or edit this file with your credentials to logon to the ESXi host.

The `vm_name` variable will be used for the name of the artifact (VM) to be created within ESXi as well as the hostname of the server.

**CAVEAT 1**
This `variables.json` is ***not*** is not included in `.gitignore`. Please be careful if you use this file so that it does not accidentally get commited and pushed with your credentials.

**CAVEAT 2**
If possible, make sure following two variables are separate datastores.

```
    "esxi_vm_datastore": "",
    "esxi_cache_datastore": "",
```
If it is not possible, then leave the `esxi_cache_datastore` blank. The reason this template is configured as such is because I was experiencing issues placing the cache and VM in the same datastore, and I have not had much time to look into it. This behavior will be examined closely in the future.

Alternatively, put your datastore name in the `remote_datastore` variable and remove `remote_cache_datastore` from the `ubuntu-1804.json` file. 

### preseed.cfg

The preseed file is creating a user going by the name of `dummy`. 

You may replace this username with anything you want. If replacing the user, please make sure the seeded `late-command` option is updated as well, as this is making sure that the newly created user can escalate privileges without having to input a password. Not doing this may cause Ansible to fail.

### variables.yml

Modify this file only if you have modified the preseed file's default user (`dummy`). 

Failure to do this will cause Ansible to fail, as it is using `dummy` to perform all of the post-install configurations.

### ubuntu-1804.json

#### Boot commands
You may change the boot commands as you see fit. 

#### Server ISO
You may modify the `iso_urls` variable if you'd like to use a different version of Ubuntu. Please note that if you do not have the ISO, it will be automatically downloaded by Packer and uploaded to the ESXi remote cache. To speed things up, *place the ISO file in the "iso" directory in this package*.

Additionally, using a different version of Ubuntu may require further tweaks. This template has been tested with `ubuntu 18.04.1`

## Running the template

```
packer build -var-file variables.json ubuntu-1804.json 
```