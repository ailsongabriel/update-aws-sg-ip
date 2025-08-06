# 🔐 AWS Security Group IP Auto-Updater (PowerShell)

This PowerShell script automatically updates the IP address of a specified AWS Security Group rule (e.g., for MySQL, RDP, or SSH access), based on your machine's current public IP address.

---

## 💡 Why This Script Exists

If your public IP address changes frequently (for example, in a home or office with a dynamic IP), accessing AWS resources like EC2 instances or databases becomes frustrating — you constantly have to manually update the IP in the security group to maintain access.

This script automates that process by:
- Detecting your current public IP address
- Updating the AWS Security Group to allow access from that IP
- (Optionally) Revoking the previous IP rule
- Storing the last used IP locally to avoid redundant updates

---

## 📌 Features

- Fully automated using PowerShell and AWS CLI
- Works for any TCP port (MySQL, SSH, RDP, etc.)
- Minimal configuration required
- Can be scheduled to run daily via Windows Task Scheduler

---

## ⚙️ Requirements

- [PowerShell 5.1+](https://learn.microsoft.com/en-us/powershell/)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- AWS credentials configured (`aws configure`)
  - Required permissions:
    - `ec2:RevokeSecurityGroupIngress`
    - `ec2:AuthorizeSecurityGroupIngress`

---

## 🚀 Setup and Usage

1. Clone this repository or download the script file:

   ```powershell
   git clone https://github.com/ailsongabriel/update-aws-sg-ip.git
   cd update-aws-sg-ip

2. Open `update-aws-sg-ip.ps1` and edit the following variables:

   ```powershell
   $securityGroupId = "sg-1234567890ABCDEFG"  # Replace with your actual security group ID
   $protocol = "tcp" # Change to the protocol you need (tcp, udp, etc.)
   $port = 3306  # Change this to the port you want to allow (e.g., 3389 for RDP, 22 for SSH)
   ```

3. Run the script manually to test:

   ```powershell
   powershell.exe -ExecutionPolicy Bypass -File .\update-sg-ip.ps1
   ```

4. (Optional) Schedule it using Windows Task Scheduler for automatic daily execution.

---

## 🕒 Task Scheduler Setup (Windows)

1. Open **Task Scheduler** → **Create Task**
2. Under **General**:

   * Name: `Update AWS Security Group IP`
   * Run with highest privileges
3. Under **Triggers**:

   * Add → Daily → Select your preferred time
4. Under **Actions**:

   * Program/script:

     ```
     powershell.exe
     ```
   * Add arguments:

     ```
     -ExecutionPolicy Bypass -File "C:\path\to\update-sg-ip.ps1"
     ```

---

## 📂 Notes

* The script stores the last known IP in `ip.txt` (same folder).
* If `ip.txt` is missing, the script will simply authorize the current IP.

