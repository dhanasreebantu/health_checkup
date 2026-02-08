# Automated Server Health Monitoring & Backup System

## 📌 Project Overview
This project is a Linux-based automation system built using **Bash scripting** to monitor server health and perform **daily automated backups**.  
It is designed to reduce manual server maintenance by automatically checking system resources, cleaning old logs, creating compressed backups, and uploading them to a backup location.

This project reflects **real-world DevOps and Linux administration practices**.

---

## 🎯 Features
- ✅ CPU usage monitoring
- ✅ Memory usage monitoring
- ✅ Disk usage monitoring
- ✅ Automatic cleanup of old log files
- ✅ Daily compressed backups
- ✅ Backup upload to a secondary location
- ✅ Auto-deletion of old backups
- ✅ Fully automated using cron jobs

---

## 🛠️ Technologies Used
- Linux (Ubuntu)
- Bash Shell Scripting
- Cron (Job Scheduling)
- Linux system utilities (`top`, `free`, `df`, `tar`, `find`)

---

## 📂 Project Structure
health_checkup.sh
backup/
├── archive/
│ └── home_backup_YYYY-MM-DD.tar.gz
└── uploaded/
└── home_backup_YYYY-MM-DD.tar.gz

---

## ⚙️ How It Works
1. The script checks CPU, memory, and disk usage against predefined thresholds.
2. If disk usage exceeds the limit, old log files are deleted automatically.
3. A daily backup of the home directory is created in compressed `.tar.gz` format.
4. The backup file is uploaded to a secondary backup directory.
5. Backups older than 7 days are automatically removed.
6. The script can be scheduled to run daily using cron.

---

## ⏰ Automation Using Cron
Example cron job to run the script daily at 9 AM:

```bash
0 9 * * * /home/ubuntu/health_checkup.sh >> /home/ubuntu/health_checkup.log

---

## sample output
CPU usage is normal
Memory usage is normal
Disk usage is normal
Backup created successfully
Backup uploaded successfully
Old backups cleaned

---
