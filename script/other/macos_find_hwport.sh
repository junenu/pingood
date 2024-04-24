#!/bin/bash

device_name=$1

get_hwport() {
    lines=()
    while IFS= read -r line; do
        lines+=("$line")
    done < <(networksetup -listallhardwareports)

    for ((i=0; i<${#lines[@]}; i++)); do
        if [[ ${lines[$i]} =~ "Device: $device_name" ]]; then
            echo ${lines[$i-1]} | awk '{$1=$2="";print $0}'
            return
        fi
    done

    echo "Error: Device not found"
}

get_hwport

# Usage
# $ ./macos_find_hwport.sh en0
# Wi-Fi