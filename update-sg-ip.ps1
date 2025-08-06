# AWS Security Group IP Auto-Updater
# This script fetches the current public IP and updates an AWS Security Group rule accordingly.

$ipFilePath = "ip.txt"
$currentIp = (Invoke-WebRequest -Uri "https://api.ipify.org").Content.Trim()
$securityGroupId = "sg-1234567890ABCDEFG"  # Replace with your actual security group ID
$protocol = "tcp" # Change to the protocol you need (tcp, udp, etc.)
$port = 3306  # Change this to the port you want to allow (e.g., 3389 for RDP, 22 for SSH)

# Check if the file with the previous IP exists
if (Test-Path $ipFilePath) {
  $previousIp = Get-Content -Path $ipFilePath
} else {
  $previousIp = $null
}

# If the current IP is different from the previous one (or no previous exists)
if (-not $previousIp -or $currentIp -ne $previousIp) {
  if ($previousIp) {
    Write-Host "Revoking previous access: $previousIp"
    aws ec2 revoke-security-group-ingress --group-id $securityGroupId --protocol $protocol --port $port --cidr "$previousIp/32"
  }

  Write-Host "Authorizing new access: $currentIp"
  aws ec2 authorize-security-group-ingress --group-id $securityGroupId --protocol $protocol --port $port --cidr "$currentIp/32"

  # Save the new IP to file
  $currentIp | Out-File -FilePath $ipFilePath -Encoding ascii
} else {
  Write-Host "Current IP ($currentIp) is the same as the previous one. No action required."
}
