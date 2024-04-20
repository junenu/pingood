# MACOS 

## 802.1q

### Enable 802.1q

<if_name> = vlan<vlan_id>
ex. <if_name> = vlan100

```bash
sudo ifconfig <if_name> create
sudo ifconfig <if_name> vlan <vlan_id>  vlandev <parent_if_name>
sudo ifconfig <if_name> inet <ip_address> netmask <netmask> 
```

### Disable 802.1q

```bash
sudo ifconfig vlan<vlan_id> destroy
```

### Gateway

```bash
sudo route add default <gateway_ip>
```