#!/bin/bash
CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=75
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) ))
then
  echo "⚠️ CPU usage is high: $CPU_USAGE%"
else
  echo "✅ CPU usage is normal: $CPU_USAGE%"
fi
MEM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')

if (( $(echo "$MEM_USAGE > $MEM_THRESHOLD" | bc -l) ))
then
  echo "⚠️ Memory usage is high: $MEM_USAGE%"
else
  echo "✅ Memory usage is normal: $MEM_USAGE%"
fi
DISK_USAGE=$(df / | grep / | awk '{print $5}' | sed 's/%//g')
if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]
then
  echo "⚠️ Disk usage is high: $DISK_USAGE%"
  echo "🧹 Cleaning old log files..."

  find /var/log -type f -name "*.log" -mtime +7 -delete

  echo "✅ Old logs deleted successfully"
else
  echo "✅ Disk usage is normal: $DISK_USAGE%"
fi
# ===== DAILY BACKUP SECTION =====

BACKUP_SOURCE="$HOME"
BACKUP_ARCHIVE="$HOME/backup/archive"
UPLOAD_DEST="$HOME/backup/uploaded"
DATE=$(date +%F)

echo "📦 Starting daily backup..."

tar -czf $BACKUP_ARCHIVE/home_backup_$DATE.tar.gz $BACKUP_SOURCE

if [ $? -eq 0 ]
then
  echo "✅ Backup created successfully"
  cp $BACKUP_ARCHIVE/home_backup_$DATE.tar.gz $UPLOAD_DEST
  echo "📤 Backup uploaded successfully"
else
  echo "❌ Backup failed"
fi

echo "🧹 Cleaning backups older than 7 days..."
find $BACKUP_ARCHIVE -type f -mtime +7 -delete

