#!/bin/bash
# Set DNS on macOS
# Usage: ./macos_setdns.sh
# Author: june@wanpachi.dev

set -e

read -p "Enter the interface name(ex. en4): " device_name
read -p "Enter the first DNS server: " dns1
read -p "Enter the second DNS server: " dns2
# If DNS server is empty, set "Empty"
if [ -z "$dns1" ] && [ -z "$dns2" ]; then
    dns1="Empty"
fi
hardware_port=""

# Define function
## Get hardware port
get_hwport() {
    lines=()
    while IFS= read -r line; do
        lines+=("$line")
    done < <(networksetup -listallhardwareports)

    for ((i=0; i<${#lines[@]}; i++)); do
        if [[ ${lines[$i]} =~ "Device: $device_name" ]]; then
            hardware_port=$(echo "${lines[$i-1]}" | awk '{$1=$2="";print $0}')
            hardware_port=$(echo "$hardware_port" | sed 's/^ *//;s/ *$//')
            return
        fi
    done

    echo "Error: Device not found"
    exit 1
}

get_hwport

networksetup -setdnsservers "$hardware_port" $dns1 $dns2

# Example
# en6 = "Belkin USB-C LAN"

#❯ networksetup -getdnsservers "Belkin USB-C LAN"
# There aren't any DNS Servers set on Belkin USB-C LAN.
# ❯ ./macos_setdns.sh
# Enter the interface name(ex. en4): en6
# Enter the first DNS server: 8.8.8.8
# Enter the second DNS server: 8.8.8.4
#
# ❯ networksetup -getdnsservers "Belkin USB-C LAN"
# 8.8.8.8
# 8.8.8.4
# ❯ ./macos_setdns.sh
# Enter the interface name(ex. en4): en6
# Enter the first DNS server: 
# Enter the second DNS server: 
# ❯ networksetup -getdnsservers "Belkin USB-C LAN"
# There aren't any DNS Servers set on Belkin USB-C LAN.