#!/bin/bash
# AWS Security Group IP Auto-Updater (Bash Version)

ip_file="ip.txt"
current_ip=$(curl -s https://api.ipify.org)
securityGroupId="sg-1234567890ABCDEFG"  # Replace with your actual security group ID
protocol="tcp" # Change to the protocol you need (tcp, udp, etc.)
port=3306  # Change this to the port you want to allow (e.g., 3389 for RDP, 22 for SSH)

# Check if the file with the previous IP exists
if [[ -f "$ip_file" ]]; then
  previous_ip=$(cat "$ip_file")
else
  previous_ip=""
fi

# If the current IP is different from the previous one (or no previous exists)
if [[ "$current_ip" != "$previous_ip" ]]; then
  if [[ -n "$previous_ip" ]]; then
    echo "Revoking previous access: $previousIp"
    aws ec2 revoke-security-group-ingress --group-id "$security_group_id" --protocol "$protocol" --port "$port" --cidr "$previous_ip/32"
  fi

  echo "Authorizing new access: $currentIp"
  aws ec2 authorize-security-group-ingress --group-id "$security_group_id" --protocol "$protocol" --port "$port" --cidr "$current_ip/32"

  # Save the new IP to file
  echo "$current_ip" > "$ip_file"
else
    echo "Current IP ($currentIp) is the same as the previous one. No action required."
fi
