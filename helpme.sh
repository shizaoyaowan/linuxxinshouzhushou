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

# 主菜单
show_main_menu() {
    clear
    echo "${GREEN}=======================================${NC}"
    echo "${YELLOW}        Linux命令行使用指南${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}基础命令介绍${NC}"
    echo "${BLUE}2. ${WHITE}文件管理命令${NC}"
    echo "${BLUE}3. ${WHITE}系统管理命令${NC}"
    echo "${BLUE}4. ${WHITE}网络命令${NC}"
    echo "${BLUE}5. ${WHITE}快捷操作与别名${NC}"
    echo "${BLUE}6. ${WHITE}系统监测工具${NC}"
    echo "${BLUE}7. ${WHITE}常见问题解答${NC}"
    echo "${BLUE}8. ${WHITE}退出指南${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择要查看的内容 (1-8): ${NC}" choice
    
    case $choice in
        1)
            show_basic_commands
            ;;
        2)
            show_file_commands
            ;;
        3)
            show_system_commands
            ;;
        4)
            show_network_commands
            ;;
        5)
            show_shortcuts
            ;;
        6)
            show_monitoring_tools
            ;;
        7)
            show_faq
            ;;
        8)
            echo "${GREEN}感谢使用Linux命令行指南！${NC}"
            return
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            show_main_menu
            ;;
    esac
}

# 基础命令介绍
show_basic_commands() {
    clear
    echo "${GREEN}=======================================${NC}"
    echo "${YELLOW}        基础命令介绍${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}ls${NC} - 列出文件和目录"
    echo "${BLUE}cd${NC} - 切换目录"
    echo "${BLUE}pwd${NC} - 显示当前目录"
    echo "${BLUE}mkdir${NC} - 创建目录"
    echo "${BLUE}rmdir${NC} - 删除空目录"
    echo "${BLUE}touch${NC} - 创建空文件"
    echo "${BLUE}cat${NC} - 查看文件内容"
    echo "${BLUE}echo${NC} - 输出文本"
    echo "${BLUE}man${NC} - 查看命令手册"
    echo "${BLUE}help${NC} - 查看内置命令帮助"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}按Enter键返回主菜单...${NC}"
    show_main_menu
}

# 文件管理命令
show_file_commands() {
    clear
    echo "${GREEN}=======================================${NC}"
    echo "${YELLOW}        文件管理命令${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}cp${NC} - 复制文件和目录"
    echo "${BLUE}mv${NC} - 移动/重命名文件和目录"
    echo "${BLUE}rm${NC} - 删除文件和目录"
    echo "${BLUE}find${NC} - 查找文件和目录"
    echo "${BLUE}grep${NC} - 在文件中搜索文本"
    echo "${BLUE}sed${NC} - 文本替换工具"
    echo "${BLUE}awk${NC} - 文本处理工具"
    echo "${BLUE}tar${NC} - 打包和压缩文件"
    echo "${BLUE}gzip${NC} - 压缩文件"
    echo "${BLUE}unzip${NC} - 解压缩文件"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}按Enter键返回主菜单...${NC}"
    show_main_menu
}

# 系统管理命令
show_system_commands() {
    clear
    echo "${GREEN}=======================================${NC}"
    echo "${YELLOW}        系统管理命令${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}ps${NC} - 查看进程状态"
    echo "${BLUE}top${NC} - 实时查看系统资源"
    echo "${BLUE}kill${NC} - 终止进程"
    echo "${BLUE}df${NC} - 查看磁盘使用情况"
    echo "${BLUE}du${NC} - 查看目录大小"
    echo "${BLUE}free${NC} - 查看内存使用情况"
    echo "${BLUE}uname${NC} - 查看系统信息"
    echo "${BLUE}whoami${NC} - 显示当前用户"
    echo "${BLUE}id${NC} - 查看用户和组信息"
    echo "${BLUE}passwd${NC} - 修改密码"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}按Enter键返回主菜单...${NC}"
    show_main_menu
}

# 网络命令
show_network_commands() {
    clear
    echo "${GREEN}=======================================${NC}"
    echo "${YELLOW}        网络命令${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}ping${NC} - 测试网络连接"
    echo "${BLUE}ifconfig${NC} - 查看网络接口信息"
    echo "${BLUE}ip${NC} - 网络配置工具"
    echo "${BLUE}netstat${NC} - 查看网络状态"
    echo "${BLUE}ss${NC} - 查看套接字状态"
    echo "${BLUE}curl${NC} - 网络请求工具"
    echo "${BLUE}wget${NC} - 下载文件"
    echo "${BLUE}ssh${NC} - 远程登录"
    echo "${BLUE}scp${NC} - 远程复制文件"
    echo "${BLUE}ftp${NC} - 文件传输协议"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}按Enter键返回主菜单...${NC}"
    show_main_menu
}

# 快捷操作与别名
show_shortcuts() {
    clear
    echo "${GREEN}=======================================${NC}"
    echo "${YELLOW}        快捷操作与别名${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}Tab${NC} - 自动补全"
    echo "${BLUE}Ctrl+C${NC} - 终止当前命令"
    echo "${BLUE}Ctrl+D${NC} - 退出终端"
    echo "${BLUE}Ctrl+L${NC} - 清屏"
    echo "${BLUE}↑↓${NC} - 浏览历史命令"
    echo "${BLUE}ll${NC} - 详细列出文件"
    echo "${BLUE}la${NC} - 列出所有文件（包括隐藏）"
    echo "${BLUE}..${NC} - 上一级目录"
    echo "${BLUE}...${NC} - 上两级目录"
    echo "${BLUE}c${NC} - 清屏"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}按Enter键返回主菜单...${NC}"
    show_main_menu
}

# 系统监测工具
show_monitoring_tools() {
    clear
    echo "${GREEN}=======================================${NC}"
    echo "${YELLOW}        系统监测工具${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}top${NC} - 实时系统监控"
    echo "${BLUE}htop${NC} - 交互式系统监控"
    echo "${BLUE}iotop${NC} - 磁盘I/O监控"
    echo "${BLUE}vmstat${NC} - 虚拟内存统计"
    echo "${BLUE}iostat${NC} - 磁盘I/O统计"
    echo "${BLUE}mpstat${NC} - CPU使用统计"
    echo "${BLUE}netstat${NC} - 网络连接监控"
    echo "${BLUE}ss${NC} - 套接字统计"
    echo "${BLUE}ps aux${NC} - 详细进程信息"
    echo "${BLUE}free -h${NC} - 内存使用情况"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}按Enter键返回主菜单...${NC}"
    show_main_menu
}

# 常见问题解答
show_faq() {
    clear
    echo "${GREEN}=======================================${NC}"
    echo "${YELLOW}        常见问题解答${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}Q: 如何复制文件？${NC}"
    echo "${WHITE}A: 使用 cp 命令，例如: cp file1 file2${NC}"
    echo "${BLUE}Q: 如何删除文件？${NC}"
    echo "${WHITE}A: 使用 rm 命令，例如: rm file${NC}"
    echo "${BLUE}Q: 如何查看文件内容？${NC}"
    echo "${WHITE}A: 使用 cat、less 或 more 命令${NC}"
    echo "${BLUE}Q: 如何创建目录？${NC}"
    echo "${WHITE}A: 使用 mkdir 命令，例如: mkdir dir${NC}"
    echo "${BLUE}Q: 如何查看系统信息？${NC}"
    echo "${WHITE}A: 使用 uname -a 命令${NC}"
    echo "${BLUE}Q: 如何查看磁盘使用情况？${NC}"
    echo "${WHITE}A: 使用 df -h 命令${NC}"
    echo "${BLUE}Q: 如何查看内存使用情况？${NC}"
    echo "${WHITE}A: 使用 free -h 命令${NC}"
    echo "${BLUE}Q: 如何查看进程？${NC}"
    echo "${WHITE}A: 使用 ps 或 top 命令${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}按Enter键返回主菜单...${NC}"
    show_main_menu
}

# 启动指南
show_main_menu