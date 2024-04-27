#!/bin/bash

    if getent group webAdmins > /dev/null; then
        # Fetch and print the list of users in 'webAdmins'
        echo "List of users in the 'webAdmins' group:"
        getent group webAdmins | awk -F: '{print $4}' | tr ',' '\n'
    else
        echo "The group 'webAdmins' does not exist."
    fi