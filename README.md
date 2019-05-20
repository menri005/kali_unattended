# Kali Linux Template (using Packer)

## Description

This is a template for an unattended install of Kali Linux using Packer and VMWare ESXi. 

Currently tested with:
  * Kali 2019.1 on xfce (though other desktop environments *should* work).
  * Packer 1.3.4
  * Ansible 2.7.7
  * ESXi 6.7.0

The `build_kali.sh` script is there to faciliate running Packer either in debug mode or normal. 

## Packer Variables

`variables.json` is an example of the required parameters for Packer to work with ESXi. 

Modify this file with your environment details and save it as `my-variables.json` in order for the `build_kali.sh` script to work, or feel free to modify the shell script to use your own variables file. 

## Packer and ESXi Oddities

I **highly** recommend that you store the VM in a separate datastore than the cache datastore as I ran into some bugs trying to upload the VM and cached files in the same datastore (though they might have fixed that in newer versions of Packer).

You'll also need to preconfigure ESXi's firewall to allow Packer to use VNC. Follow this guide: 
https://nickcharlton.net/posts/using-packer-esxi-6.html

I may update this repository to include a "local" template that uses VMWare Fusion (or Workstation) to create the Kali image and *optionally* uploads it to ESXi, or vagrant cloud.


## Pre and Post Seeding

The `http` directory contains the `preseed.cfg` file and postseed scripts. Please check these out if you need to make modifications. At the moment, these enable SSH in Kali (as its disabled by default) in order to set the stage for provisioners like Ansible.

## Ansible

An Ansible playbook with a "common" role has been included in this template if you need to do some more work beyond the post seeding scripts. This playbook will most likely be enhanced in the future.

