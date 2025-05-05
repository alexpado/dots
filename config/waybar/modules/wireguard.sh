#!/bin/bash

# This script will toggle the wireguard connection upon being called.
WG_INTERFACE="akio-home"

if ip link show "$WG_INTERFACE" up &>/dev/null; then
    sudo wg-quick down "$WG_INTERFACE"
else
    sudo wg-quick up "$WG_INTERFACE"
fi