# 🔐 AWS Security Group IP Auto-Updater

Scripts to automatically update the allowed IP address of an AWS Security Group inbound rule based on your machine's current public IP.

Includes:

* **PowerShell version** (Windows)
* **Bash version** (Linux/macOS)

---

## 💡 Why This Script Exists

If your public IP address changes frequently (for example, on a home or office network with a dynamic IP), accessing AWS resources like EC2 instances or databases becomes frustrating.
You constantly have to manually update the IP in the Security Group to maintain access.

These scripts automate that process by:

* Detecting your current public IP address
* Updating the AWS Security Group to allow access from that IP
* (Optionally) Revoking the previous IP rule
* Storing the last used IP locally to avoid redundant updates

---

## 📌 Features

* Fully automated via AWS CLI
* Works for any inbound or outbound rule in a Security Group
* Minimal configuration required
* Can be scheduled:
  * **Windows Task Scheduler** (PowerShell)
  * **cron** (Bash)
---

## ⚙️ Requirements

### PowerShell (Windows)

* [PowerShell 5.1+](https://learn.microsoft.com/en-us/powershell/)
* [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
* AWS credentials configured (`aws configure`)
* Required permissions:
  * `ec2:RevokeSecurityGroupIngress`
  * `ec2:AuthorizeSecurityGroupIngress`

### Bash (Linux/macOS)

* [Bash 4+](https://www.gnu.org/software/bash/)
* [curl](https://curl.se/)
* [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
* AWS credentials configured (`aws configure`)
* Required permissions:
  * `ec2:RevokeSecurityGroupIngress`
  * `ec2:AuthorizeSecurityGroupIngress`

---

## 🚀 Setup and Usage

### PowerShell (Windows)

1. Clone the repository:

   ```powershell
   git clone https://github.com/ailsongabriel/update-aws-sg-ip.git
   cd update-aws-sg-ip
   ```

2. Edit the `update-sg-ip.ps1` file:

   ```powershell
   $securityGroupId = "sg-1234567890ABCDEFG"
   $protocol = "tcp"
   $port = 3306
   ```

3. Run the script:

   ```powershell
   .\update-sg-ip.ps1
   ```

---

### Bash (Linux/macOS)

1. Clone the repository:

   ```bash
   git clone https://github.com/ailsongabriel/update-aws-sg-ip.git
   cd update-aws-sg-ip
   ```

2. Edit the `update-sg-ip.sh` file:

   ```bash
   security_group_id="sg-1234567890ABCDEFG"
   protocol="tcp"
   port=3306
   ```

3. Make it executable:

   ```bash
   chmod +x update-sg-ip.sh
   ```

4. Run the script:

   ```bash
   ./update-sg-ip.sh
   ```

---

## 📂 Notes

* Both scripts store the last known IP in `ip.txt` (in the same folder).
* If `ip.txt` is missing, the script will simply authorize the current IP.

---
