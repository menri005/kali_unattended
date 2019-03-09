#!/bin/bash

chmod 644 /etc/vmware/firewall/service.xml
cp service.xml /etc/vmware/firewall/service.xml
esxcli network firewall refresh