#!/bin/bash
# author: junenu41@gmail.com

set -e

read -p "Enter the interface name(ex. en4): " device_name
read -p "plz select add type(DHCP:0,Manual:1) : " add_type
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

## Convert CIDR to netmask
cidr2mask() {
  local i mask=""
  local full_octet=255
  
  if [ $1 -lt 1 ] || [ $1 -gt 32 ]; then
    echo "Error: Invalid subnet"
    return 1
  fi
  for ((i=0;i<4;i+=1)); do
    local end=$(( ( $1 / 8 ) - $i ))
    if [ $end -gt 0 ]; then
      mask+=${full_octet} 
    elif [ $end -eq 0 ]; then
      local rest=$(( $1 % 8 ))
      local last_octet=$(( ( $full_octet << ( 8 - $rest ) ) & $full_octet ))
      mask+=${last_octet}
    else
      mask+=0
    fi
    test $i -lt 3 && mask+=.
  done
  echo $mask
}

# Main
get_hwport

if [ $add_type -eq 0 ]; then
    networksetup -setdhcp "$hardware_port"
elif [ $add_type -eq 1 ]; then
    read -p "Enter the IP address: " ip_address
    read -p "Enter the subnet mask(ex. 24): " subnet_mask
    read -p "Enter the gateway: " default_gateway
    subnet_mask=$(cidr2mask $subnet_mask)
    networksetup -setmanual "$hardware_port" $ip_address $subnet_mask $default_gateway
fi

echo "Done"

# Usage
#❯ ./script/masos_setipv4.sh
#Enter the interface name(ex. en4): en6
#plz select add type(DHCP:0,Manual:1) : 1
#Enter the IP address: 192.168.1.1               
#Enter the subnet mask(ex. 24): 24
#Enter the gateway: 192.168.1.254
#Done
#❯ ./script/masos_setipv4.sh
#Enter the interface name(ex. en4): en6
#plz select add type(DHCP:0,Manual:1) : 0
#Done