#!/usr/bin/python3
# original software is "dcheck"
# coding by junenu(june@wanpachi.dev)

import re
import os
import platform
import sys
import socket
import subprocess

SOFTWARE_NAME = "dcheck"
SOFTWARE_VERSION = "0.1.0"
OS_NAME = platform.system()
ADAPTER_NAME = sys.argv[1]

ICMP_INTERVAL = 0.5
ICMP_COUNT = 3

GOOGLE_DNS_1 = "8.8.8.8"
PRIVATE_DNS_1 = "192.168.10.1"

YAHOO_DOMAIN = "yahoo.com"
GOOGLE_DOMAIN = "google.com"

# print software name and version
print(SOFTWARE_NAME + " " + SOFTWARE_VERSION)

# check ip address module
def check_ipv4_address_win():
	hostname = socket.gethostname()
	ipv4_address = socket.gethostbyname(hostname)
	process = subprocess.Popen("ipconfig", stdout=subprocess.PIPE)
	out, err = process.communicate()
	ipv4_default_gateway = re.findall(r"Default Gateway . . . . . . . . . : ([^\s]+)", out.decode())

	print("IPv4 Address:", ipv4_address)
	print("IPv4 Default Gateway:", ipv4_default_gateway[0] if ipv4_default_gateway else "Not found")

def check_ipv6_address_win():
    hostname = socket.gethostname()
    ipv6_address = socket.getaddrinfo(hostname, None, socket.AF_INET6)
    process = subprocess.Popen("ipconfig", stdout=subprocess.PIPE)
    out, err = process.communicate()
    ipv6_default_gateway = re.findall(r"Default Gateway . . . . . . . . . : ([^\s]+)", out.decode())

    print("IPv6 Address:", ipv6_address[0][4][0] if ipv6_address else "Not found")
    print("IPv6 Default Gateway:", ipv6_default_gateway[0] if ipv6_default_gateway else "Not found")

def check_ip_address():
	if OS_NAME == "Windows":
		check_ipv4_address_win()
		check_ipv6_address_win()
	
	else:
		print("Not supported OS.")
		exit()

# ping check module
		
def check_ping_win(PING_TARGET=None):
	print("Not supported OS.")
	
def check_ping(PING_TARGET=None):
	if OS_NAME == "Windows":
		check_ping_win(PING_TARGET)
	else:
		print("Not supported OS.")
		exit()

# dns check module
def check_ipv4dns_mac(DOMAIN_NAME):
	result = subprocess.run(["dig", DOMAIN_NAME, "A", "+short"], stdout=subprocess.PIPE)
	if result.returncode == 0:
		print("DNS resolution to", DOMAIN_NAME, "OK")
		print(result.stdout.decode())
	else:
		print("DNS resolution to", DOMAIN_NAME, "NG")
	
def check_ipv4dns_win():
    print("Not supported OS.")
	
def check_dns(DOMAIN_NAME):
	if OS_NAME == "Windows":
		check_ipv4dns_win(DOMAIN_NAME)
	elif OS_NAME == "Darwin" or OS_NAME == "Linux":
		check_ipv4dns_mac(DOMAIN_NAME)
	else:
		print("Not supported OS.")
		exit()

# main precedure
def main():
	print("------------ip address------------")
	print("Interface:", ADAPTER_NAME)
	check_ip_address()
	print("------------ping------------")
	check_ping()
	check_ping(GOOGLE_DNS_1)
	print("------------dns------------")
	check_dns(YAHOO_DOMAIN)
	check_dns(GOOGLE_DOMAIN)
	
	

if __name__ == "__main__":
	main()

#def show_ip_address(adapter_name):