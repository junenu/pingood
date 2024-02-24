# dropcheck

## memo

```
PS C:\Users\hogehoge> (Get-NetIPAddress | Where-Object {$_.AddressFamily -eq "IPv4"} | Where-Object {$_.InterfaceIndex -eq 26}).IPAddress
192.168.11.100
PS C:\Users\hogehoge> (Get-NetRoute "0.0.0.0/0").NextHop
192.168.10.1
```