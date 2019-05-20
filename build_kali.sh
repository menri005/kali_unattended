#!/bin/bash

debug () {
    PACKER_LOG=1 packer build -var-file my-variables.json kali.json
}

if "$1" != "debug"; then
    packer build -var-file my-variables.json kali.json
else
    debug
fi
