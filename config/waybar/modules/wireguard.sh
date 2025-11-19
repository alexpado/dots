#!/bin/bash

# This script will toggle the wireguard connection upon being called.
WG_INTERFACE="akio-home"

# Refresh resolvconf
# I need to do this way too many time, so its presence here is justified
sudo resolvconf -u

if ip link show "$WG_INTERFACE" up &>/dev/null; then
    sudo wg-quick down "$WG_INTERFACE"
else
    sudo wg-quick up "$WG_INTERFACE"
fi
