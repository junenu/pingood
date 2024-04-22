#!/bin/bash

# Change VLAN on macOS
# Usage: ./macos_change_vlan.sh <interface> 
# Example: ./macos_change_vlan.sh en0

interface=$1

old_vlan=$(ifconfig | grep vlan: | cut -c 8- | sed 's/parent.*//')
if [ -n "$old_vlan" ]; then
  networksetup -deleteVLAN vlan0 $interface $old_vlan
fi
read -p "vlan ID:" vlan
if [ $vlan = 0 ]; then
    exit $status
fi
networksetup -createVLAN vlan0 $interface $vlan

# ❯ ./script/macos_change_vlan.sh en4
# vlan ID:400
# ❯ ifconfig vlan0
#vlan0: flags=8843<UP,BROADCAST,RUNNING,SIMPLEX,MULTICAST> mtu 1500
#        options=6063<RXCSUM,TXCSUM,TSO4,TSO6,PARTIAL_CSUM,ZEROINVERT_CSUM>
#        ether 80:69:1a:17:51:f5
#        nd6 options=201<PERFORMNUD,DAD>
#        vlan: 400 parent interface: en4
#        media: autoselect (none)
#        status: inactive