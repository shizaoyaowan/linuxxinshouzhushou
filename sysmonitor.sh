#!/bin/bash

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
NC='\033[0m' # No Color

# 清屏
clear

# 显示标题
echo "${GREEN}=======================================${NC}"
echo "${YELLOW}        系统监测工具${NC}"
echo "${GREEN}=======================================${NC}"

# 显示系统信息
echo "${BLUE}系统信息:${NC}"
uname -a
echo

# 显示CPU信息
echo "${BLUE}CPU使用情况:${NC}"
if command -v mpstat &> /dev/null; then
    mpstat 1 1
else
    top -bn1 | grep "Cpu(s)"
fi
echo

# 显示内存使用情况
echo "${BLUE}内存使用情况:${NC}"
free -h
echo

# 显示磁盘使用情况
echo "${BLUE}磁盘使用情况:${NC}"
df -h
echo

# 显示磁盘I/O情况
echo "${BLUE}磁盘I/O情况:${NC}"
if command -v iostat &> /dev/null; then
    iostat -d -x
else
    echo "iostat 命令未安装"
fi
echo

# 显示网络状态
echo "${BLUE}网络状态:${NC}"
if command -v netstat &> /dev/null; then
    netstat -tuln | head -20
elif command -v ss &> /dev/null; then
    ss -tuln | head -20
else
    echo "网络状态命令未安装"
fi
echo

# 显示进程信息
echo "${BLUE}进程信息 (前10个占用CPU最多的进程):${NC}"
ps aux --sort=-%cpu | head -11
echo

# 显示系统负载
echo "${BLUE}系统负载:${NC}"
uptime
echo

# 显示开机时间
echo "${BLUE}开机时间:${NC}"
if command -v uptime &> /dev/null; then
    uptime -s
else
    who -b
fi
echo

# 显示当前用户
echo "${BLUE}当前用户:${NC}"
who
echo

# 显示文件系统inode使用情况
echo "${BLUE}文件系统inode使用情况:${NC}"
df -i | head -10
echo

# 显示硬件信息
echo "${BLUE}硬件信息:${NC}"
if command -v lshw &> /dev/null; then
    lshw -short | head -20
elif command -v lscpu &> /dev/null; then
    lscpu
else
    echo "硬件信息命令未安装"
fi
echo

# 显示结束信息
echo "${GREEN}=======================================${NC}"
echo "${YELLOW}        监测完成${NC}"
echo "${GREEN}=======================================${NC}"
echo "${WHITE}按Enter键退出...${NC}"
read