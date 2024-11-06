#!/bin/bash

# Configuration
SOURCE_DIR="/path/to/source"           # Directory to back up
REMOTE_USER="username"                  # Remote server username
REMOTE_HOST="remote.server.com"         # Remote server address
REMOTE_DIR="/path/to/backup"            # Destination directory on remote server
LOG_FILE="/path/to/backup.log"          # Log file path
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")  # Timestamp for logging

# Ensure source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "$TIMESTAMP - ERROR: Source directory $SOURCE_DIR does not exist." | tee -a "$LOG_FILE"
    exit 1
fi

# Perform the backup using rsync over SSH
echo "$TIMESTAMP - Starting backup of $SOURCE_DIR to $REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR" | tee -a "$LOG_FILE"
rsync -avz -e ssh "$SOURCE_DIR" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR" &>> "$LOG_FILE"

# Check if the rsync command was successful
if [ $? -eq 0 ]; then
    echo "$TIMESTAMP - SUCCESS: Backup completed successfully." | tee -a "$LOG_FILE"
else
    echo "$TIMESTAMP - ERROR: Backup failed. Check the log for details." | tee -a "$LOG_FILE"
fi
