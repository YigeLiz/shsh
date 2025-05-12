#!/bin/bash

#mariadb_backup_shell

BACKUP_DIR="/home/ego/myshell/backups/mariadb_backup"
DB_NAME="***"

#mkdir -p "$BACKUP_DIR"

BACKUP_FILE="$BACKUP_DIR/${DB_NAME}_backup_(date +%Y%m%d_%H%M%S).sql.gz"

mysqldump "$DB_NAME | gzip > "$BACKUP_FILE"

if [ $? -eq 0 ]; then
        echo "$BACKUP_FILE backup:success"
else
        echo "backup:failed"
        exit 1
fi

