#!/bin/bash

# 学习报告生成工具

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
NC='\033[0m' # No Color

# 清屏函数
clear_screen() {
    clear
}

# 显示标题
show_title() {
    clear_screen
    echo "${GREEN}=======================================${NC}"
    echo "${YELLOW}        Linux学习报告生成器${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}生成个人Linux学习情况报告${NC}"
    echo "${GREEN}=======================================${NC}"
}

# 生成学习报告
generate_report() {
    show_title
    echo "${YELLOW}正在生成学习报告...${NC}"
    
    # 创建报告目录
    mkdir -p ~/.linux助手/reports
    
    # 生成报告文件名
    report_file="~/.linux助手/reports/learning_report_$(date +%Y%m%d_%H%M%S).md"
    
    # 生成报告内容
    cat > "$report_file" << EOF
# 我的Linux学习报告

## 报告生成时间
$(date)

## 系统信息

### 操作系统
$(uname -a)

### 内核版本
$(uname -r)

### 系统架构
$(uname -m)

## 学习活动

### 最近使用的命令
$(history | tail -20)

### 系统操作记录
- 启动次数: $(who -b | awk '{print $3, $4}')
- 登录用户: $(who | wc -l)
- 系统运行时间: $(uptime | awk '{print $3, $4}' | sed 's/,//g')

## 文件操作

### 最近创建的文件
$(find ~ -type f -mtime -7 | head -10)

### 最近修改的文件
$(find ~ -type f -mtime -3 | head -10)

## 系统资源

### CPU使用情况
$(top -bn1 | head -10)

### 内存使用情况
$(free -h)

### 磁盘使用情况
$(df -h)

## 网络状态

### 网络接口
$(ifconfig 2>/dev/null || ip addr)

### 网络连接
$(netstat -tuln 2>/dev/null || ss -tuln)

## 学习进度

### 已学习的命令
$(history | awk '{print $2}' | sort | uniq | head -20)

### 常用命令使用频率
$(history | awk '{print $2}' | sort | uniq -c | sort -nr | head -10)

## 系统安全

### 用户账户
$(cat /etc/passwd | grep -v nologin | head -10)

### 开放端口
$(netstat -tuln 2>/dev/null | grep LISTEN || ss -tuln | grep LISTEN)

## 学习建议

### 推荐学习的命令
1. 高级文件操作: find, grep, sed, awk
2. 系统管理: systemctl, journalctl, top
3. 网络工具: netstat, ss, ping, traceroute
4. 安全工具: sudo, chmod, chown, firewall-cmd
5. 脚本编程: bash脚本基础

### 学习资源推荐
1. Linux命令行基础教程
2. 鸟哥的Linux私房菜
3. Linux从入门到精通
4. Linux系统管理实战

## 总结

这是您的Linux学习报告，展示了您的学习活动和系统状态。通过分析这些数据，您可以了解自己的学习进度，并根据建议继续提升Linux技能。

建议定期生成学习报告，跟踪您的学习进展。
EOF
    
    echo "${GREEN}学习报告生成完成！${NC}"
    echo "${YELLOW}报告文件: ${WHITE}$report_file${NC}"
    echo "${YELLOW}您可以使用以下命令查看报告:${NC}"
    echo "${WHITE}cat $report_file${NC}"
    
    read -p "${YELLOW}按Enter键返回...${NC}"
}

# 主菜单
show_main_menu() {
    show_title
    echo "${BLUE}1. ${WHITE}生成学习报告${NC}"
    echo "${BLUE}2. ${WHITE}查看历史报告${NC}"
    echo "${BLUE}3. ${WHITE}返回主菜单${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-3): ${NC}" choice
    
    case $choice in
        1)
            generate_report
            show_main_menu
            ;;
        2)
            show_title
            echo "${BLUE}历史报告${NC}"
            echo "${GREEN}=======================================${NC}"
            if [ -d ~/.linux助手/reports ]; then
                ls -la ~/.linux助手/reports/
            else
                echo "${YELLOW}没有历史报告${NC}"
            fi
            read -p "${YELLOW}按Enter键返回...${NC}"
            show_main_menu
            ;;
        3)
            return
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            show_main_menu
            ;;
    esac
}

# 启动学习报告生成器
show_main_menu