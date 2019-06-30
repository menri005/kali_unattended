#!/bin/bash

build () {
    packer build -var-file my-variables.json "$1"
}

debug () {
    PACKER_LOG=1 packer build -var-file my-variables.json "$1"
}

display_help () {
    printf "
Usage: 
    ./build-kali.sh <options>

Options:
    local | build Kali using local VMware Fusion
    remote | build Kali using remote ESXi server
    local-debug | launch Packer in debug mode for local builder
    remote-debug | launch Packer in debug mode for remote builder

"
}

if [ -z "$1" ]
    then
        display_help
else
    case "$1" in
        local) build "kali_local.json" ;;
        remote) build "kali_esxi.json" ;;
        local-debug) debug "kali_local.json" ;;
        remote-debug) debug "kali-esxi.json" ;;
        *) display_help ;;
    esac 
fi
