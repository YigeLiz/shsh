#!/bin/bash


DING_URL="https://oapi.dingtalk.com/robot/send?access_token=2063813c1de1fcfa4bdad9ffc4f0f45ed1b46aab6e57232cfba02d24caeae510"

# 检查CPU负载（1分钟平均值）
CPU_LOAD=$(uptime | awk -F 'load average:' '{print $2}' | cut -d',' -f1 | tr -d ' ')
if [ $(echo "$CPU_LOAD > 0.8" | bc) -eq 1 ]; then
    curl -sX POST "$DING_URL" -H "Content-Type: application/json" -d \
    "{\"msgtype\":\"text\",\"text\":{\"content\":\"[CPU告警] 负载值 $CPU_LOAD\"}}"
fi

# 检查内存使用率（百分比）
MEM_USAGE=$(free | awk '/Mem/{printf "%.0f", $3/$2 * 100}')
if [ $MEM_USAGE -gt 80 ]; then
    curl -sX POST "$DING_URL" -H "Content-Type: application/json" -d \
    "{\"msgtype\":\"text\",\"text\":{\"content\":\"[内存告警] 使用率 $MEM_USAGE%\"}}"
fi

# 检查磁盘根分区（百分比）
DISK_USAGE=$(df -h / | awk 'NR==2{print $5}' | tr -d '%')
if [ $DISK_USAGE -gt 80 ]; then
    curl -sX POST "$DING_URL" -H "Content-Type: application/json" -d \
    "{\"msgtype\":\"text\",\"text\":{\"content\":\"[磁盘告警] 使用率 $DISK_USAGE%\"}}"
fi

