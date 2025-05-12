#!/bin/bash

# web.mysql.backup.sh

DB_NAME="www_yigeweb_site"
BACKUP_DIR="/www/backup/database/mysql/www_yigeweb_site"
DATE=$(date +"%Y-%m-%d_%H%M%S")

# 创建备份目录
#mkdir -p $BACKUP_DIR

# 执行备份并压缩
mysqldump --defaults-file=~/.my.cnf $DB_NAME | gzip > $BACKUP_DIR/${DB_NAME}_${DATE}.sql.gz

# 输出日志
echo "[$(date)] 数据库备份完成：${DB_NAME}_${DATE}.sql.gz" >> $BACKUP_DIR/backup.log

#清理旧备份
find $BACKUP_DIR -name "*.sql.gz" -mtime +30 -delete


