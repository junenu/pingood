```
import ipaddress

# サブネットマスク付きのIPアドレス
ipv4_address_with_mask = '192.168.10.117/23'

# IPアドレスオブジェクトの作成
ip_interface = ipaddress.ip_interface(ipv4_address_with_mask)

# ネットワークアドレスの取得
network_address = ip_interface.network.network_address

print(f"ネットワークアドレス: {network_address}")
```
