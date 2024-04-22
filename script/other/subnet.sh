#!/bin/bash

# Convert CIDR to netmask
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

read -p "insert subnet(ex. 24) : " subnet
subnet=$(cidr2mask $subnet)
echo $subnet