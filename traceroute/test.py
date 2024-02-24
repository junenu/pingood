import subprocess
import re

# Parse the output of the traceroute command to extract the IP addresses
def parse_traceroute_to_ip_addresses(destination_ip):
    result = subprocess.run(["traceroute", destination_ip], capture_output=True, text=True)
    
    # Regular expression to match IP addresses
    ip_regex = r'\((\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})\)'
    
    # Parse the output
    ip_addresses = re.findall(ip_regex, result.stdout)
    
    return ip_addresses

# Example usage
destination_ip = "8.8.8.8"
ip_addresses = parse_traceroute_to_ip_addresses(destination_ip)
print(ip_addresses)
