#!/bin/bash

    # Create the group 'webAdmins' if it doesn't already exist
    if ! getent group webAdmins > /dev/null 2>&1; then
    sudo groupadd webAdmins
    fi

    # Create the user 'DevTeam' if it doesn't already exist
    if ! getent passwd DevTeam > /dev/null 2>&1; then
    sudo useradd -m -G webAdmins DevTeam
    fi

    # Create the user 'OpsTeam' if it doesn't already exist
    if ! getent passwd OpsTeam > /dev/null 2>&1; then
    sudo useradd -m -G webAdmins OpsTeam
    fi