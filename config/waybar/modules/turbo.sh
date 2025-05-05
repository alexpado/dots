#!/bin/bash

NO_TURBO=$(cat /sys/devices/system/cpu/intel_pstate/no_turbo)

case $1 in
status)
    if [ "$NO_TURBO" == "0" ]; then
        echo "{\"text\": \"\udb81\udcc5\", \"tooltip\": \"Intel Turbo enabled.\"}"
    else
        echo "{\"text\": \"\udb83\udf86\", \"tooltip\": \"Intel Turbo disabled.\"}"
    fi
    ;;
toggle)
    if [ "$NO_TURBO" == "0" ]; then
        echo "1" > /sys/devices/system/cpu/intel_pstate/no_turbo
    else
        echo "0" > /sys/devices/system/cpu/intel_pstate/no_turbo
    fi
    ;;
*)
    echo "Invalid usage: status, toggle"
    ;;
esac