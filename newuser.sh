#!/bin/bash

# 新用户辅助工具

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
    echo "${YELLOW}        Linux新用户助手${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}专为新用户设计的辅助工具${NC}"
    echo "${GREEN}=======================================${NC}"
}

# 进度条函数
progress_bar() {
    local duration=$1
    local width=50
    local progress=0
    
    echo -n "${YELLOW}执行中 [${NC}"
    
    while [ $progress -lt $width ]; do
        echo -n "${GREEN}=${NC}"
        progress=$((progress + 1))
        sleep $((duration / width))
    done
    
    echo -n "${YELLOW}] ${GREEN}完成${NC}\n"
}

# 检测包管理器
detect_package_manager() {
    if command -v apt &> /dev/null; then
        echo "apt"
    elif command -v yum &> /dev/null; then
        echo "yum"
    elif command -v dnf &> /dev/null; then
        echo "dnf"
    elif command -v pacman &> /dev/null; then
        echo "pacman"
    elif command -v zypper &> /dev/null; then
        echo "zypper"
    else
        echo "unknown"
    fi
}

# 软件包管理工具
package_manager() {
    show_title
    echo "${BLUE}软件包管理工具${NC}"
    echo "${GREEN}=======================================${NC}"
    
    local package_manager=$(detect_package_manager)
    echo "${BLUE}检测到包管理器: ${WHITE}$package_manager${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}安装软件包${NC}"
    echo "${BLUE}2. ${WHITE}卸载软件包${NC}"
    echo "${BLUE}3. ${WHITE}更新软件包${NC}"
    echo "${BLUE}4. ${WHITE}搜索软件包${NC}"
    echo "${BLUE}5. ${WHITE}查看已安装软件${NC}"
    echo "${BLUE}6. ${WHITE}返回主菜单${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-6): ${NC}" choice
    
    case $choice in
        1)
            read -p "${YELLOW}请输入要安装的软件包名称: ${NC}" package
            echo "${YELLOW}正在安装 $package...${NC}"
            
            case $package_manager in
                "apt")
                    sudo apt update && sudo apt install -y "$package"
                    ;;
                "yum")
                    sudo yum install -y "$package"
                    ;;
                "dnf")
                    sudo dnf install -y "$package"
                    ;;
                "pacman")
                    sudo pacman -S --noconfirm "$package"
                    ;;
                "zypper")
                    sudo zypper install -y "$package"
                    ;;
                *)
                    echo "${RED}无法自动安装软件包，请手动安装${NC}"
                    ;;
            esac
            
            if [ $? -eq 0 ]; then
                echo "${GREEN}安装成功！${NC}"
            else
                echo "${RED}安装失败，请检查软件包名称是否正确${NC}"
            fi
            sleep 2
            package_manager
            ;;
        2)
            read -p "${YELLOW}请输入要卸载的软件包名称: ${NC}" package
            echo "${YELLOW}正在卸载 $package...${NC}"
            
            case $package_manager in
                "apt")
                    sudo apt remove -y "$package"
                    ;;
                "yum")
                    sudo yum remove -y "$package"
                    ;;
                "dnf")
                    sudo dnf remove -y "$package"
                    ;;
                "pacman")
                    sudo pacman -R --noconfirm "$package"
                    ;;
                "zypper")
                    sudo zypper remove -y "$package"
                    ;;
                *)
                    echo "${RED}无法自动卸载软件包，请手动卸载${NC}"
                    ;;
            esac
            
            if [ $? -eq 0 ]; then
                echo "${GREEN}卸载成功！${NC}"
            else
                echo "${RED}卸载失败，请检查软件包名称是否正确${NC}"
            fi
            sleep 2
            package_manager
            ;;
        3)
            echo "${YELLOW}正在更新软件包...${NC}"
            
            case $package_manager in
                "apt")
                    sudo apt update && sudo apt upgrade -y
                    ;;
                "yum")
                    sudo yum update -y
                    ;;
                "dnf")
                    sudo dnf update -y
                    ;;
                "pacman")
                    sudo pacman -Syu --noconfirm
                    ;;
                "zypper")
                    sudo zypper update -y
                    ;;
                *)
                    echo "${RED}无法自动更新软件包，请手动更新${NC}"
                    ;;
            esac
            
            if [ $? -eq 0 ]; then
                echo "${GREEN}更新成功！${NC}"
            else
                echo "${RED}更新失败，请检查网络连接${NC}"
            fi
            sleep 2
            package_manager
            ;;
        4)
            read -p "${YELLOW}请输入要搜索的软件包名称: ${NC}" package
            echo "${YELLOW}正在搜索 $package...${NC}"
            
            case $package_manager in
                "apt")
                    apt search "$package"
                    ;;
                "yum")
                    yum search "$package"
                    ;;
                "dnf")
                    dnf search "$package"
                    ;;
                "pacman")
                    pacman -Ss "$package"
                    ;;
                "zypper")
                    zypper search "$package"
                    ;;
                *)
                    echo "${RED}无法自动搜索软件包，请手动搜索${NC}"
                    ;;
            esac
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            package_manager
            ;;
        5)
            echo "${YELLOW}正在列出已安装的软件包...${NC}"
            
            case $package_manager in
                "apt")
                    dpkg -l | head -20
                    echo "${YELLOW}显示前20个软件包，按Enter键查看更多...${NC}"
                    read
                    dpkg -l
                    ;;
                "yum")
                    yum list installed | head -20
                    echo "${YELLOW}显示前20个软件包，按Enter键查看更多...${NC}"
                    read
                    yum list installed
                    ;;
                "dnf")
                    dnf list installed | head -20
                    echo "${YELLOW}显示前20个软件包，按Enter键查看更多...${NC}"
                    read
                    dnf list installed
                    ;;
                "pacman")
                    pacman -Q | head -20
                    echo "${YELLOW}显示前20个软件包，按Enter键查看更多...${NC}"
                    read
                    pacman -Q
                    ;;
                "zypper")
                    zypper se -i | head -20
                    echo "${YELLOW}显示前20个软件包，按Enter键查看更多...${NC}"
                    read
                    zypper se -i
                    ;;
                *)
                    echo "${RED}无法自动列出软件包，请手动查看${NC}"
                    ;;
            esac
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            package_manager
            ;;
        6)
            return
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            package_manager
            ;;
    esac
}

# 系统配置向导
system_config_wizard() {
    show_title
    echo "${BLUE}系统配置向导${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}设置主机名${NC}"
    echo "${BLUE}2. ${WHITE}设置时区${NC}"
    echo "${BLUE}3. ${WHITE}设置语言${NC}"
    echo "${BLUE}4. ${WHITE}网络配置${NC}"
    echo "${BLUE}5. ${WHITE}返回主菜单${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-5): ${NC}" choice
    
    case $choice in
        1)
            read -p "${YELLOW}请输入新的主机名: ${NC}" hostname
            echo "${YELLOW}正在设置主机名...${NC}"
            
            if command -v hostnamectl &> /dev/null; then
                sudo hostnamectl set-hostname "$hostname"
            else
                echo "$hostname" > /etc/hostname
                sudo sed -i "s/127.0.1.1.*/127.0.1.1\t$hostname/g" /etc/hosts
            fi
            
            if [ $? -eq 0 ]; then
                echo "${GREEN}主机名设置成功！${NC}"
                echo "${YELLOW}新的主机名: ${WHITE}$hostname${NC}"
            else
                echo "${RED}主机名设置失败，请检查权限${NC}"
            fi
            sleep 2
            system_config_wizard
            ;;
        2)
            echo "${YELLOW}当前时区:${NC}"
            timedatectl
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请输入新的时区 (例如: Asia/Shanghai): ${NC}" timezone
            echo "${YELLOW}正在设置时区...${NC}"
            
            if command -v timedatectl &> /dev/null; then
                sudo timedatectl set-timezone "$timezone"
            else
                sudo ln -sf "/usr/share/zoneinfo/$timezone" /etc/localtime
            fi
            
            if [ $? -eq 0 ]; then
                echo "${GREEN}时区设置成功！${NC}"
                echo "${YELLOW}新的时区: ${WHITE}$timezone${NC}"
            else
                echo "${RED}时区设置失败，请检查时区格式${NC}"
            fi
            sleep 2
            system_config_wizard
            ;;
        3)
            echo "${YELLOW}当前语言设置:${NC}"
            locale
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请输入新的语言 (例如: zh_CN.UTF-8): ${NC}" language
            echo "${YELLOW}正在设置语言...${NC}"
            
            if command -v update-locale &> /dev/null; then
                sudo update-locale LANG="$language"
            else
                echo "LANG=$language" > /etc/locale.conf
            fi
            
            if [ $? -eq 0 ]; then
                echo "${GREEN}语言设置成功！${NC}"
                echo "${YELLOW}新的语言: ${WHITE}$language${NC}"
            else
                echo "${RED}语言设置失败，请检查语言格式${NC}"
            fi
            sleep 2
            system_config_wizard
            ;;
        4)
            show_title
            echo "${BLUE}网络配置${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${BLUE}1. ${WHITE}查看网络接口${NC}"
            echo "${BLUE}2. ${WHITE}查看IP地址${NC}"
            echo "${BLUE}3. ${WHITE}查看DNS配置${NC}"
            echo "${BLUE}4. ${WHITE}返回上一级${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请选择操作 (1-4): ${NC}" net_choice
            
            case $net_choice in
                1)
                    if command -v ifconfig &> /dev/null; then
                        ifconfig
                    elif command -v ip &> /dev/null; then
                        ip addr
                    else
                        echo "${RED}网络命令未安装${NC}"
                    fi
                    read -p "${YELLOW}按Enter键返回...${NC}"
                    system_config_wizard
                    ;;
                2)
                    if command -v ifconfig &> /dev/null; then
                        ifconfig | grep inet
                    elif command -v ip &> /dev/null; then
                        ip addr | grep inet
                    else
                        echo "${RED}网络命令未安装${NC}"
                    fi
                    read -p "${YELLOW}按Enter键返回...${NC}"
                    system_config_wizard
                    ;;
                3)
                    if [ -f "/etc/resolv.conf" ]; then
                        cat /etc/resolv.conf
                    else
                        echo "${RED}DNS配置文件不存在${NC}"
                    fi
                    read -p "${YELLOW}按Enter键返回...${NC}"
                    system_config_wizard
                    ;;
                4)
                    system_config_wizard
                    ;;
                *)
                    echo "${RED}无效选择，请重新输入！${NC}"
                    sleep 2
                    system_config_wizard
                    ;;
            esac
            ;;
        5)
            return
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            system_config_wizard
            ;;
    esac
}

# 问题诊断工具
problem_diagnosis() {
    show_title
    echo "${BLUE}问题诊断工具${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}网络连接诊断${NC}"
    echo "${BLUE}2. ${WHITE}磁盘空间检查${NC}"
    echo "${BLUE}3. ${WHITE}内存使用检查${NC}"
    echo "${BLUE}4. ${WHITE}系统服务状态${NC}"
    echo "${BLUE}5. ${WHITE}日志检查${NC}"
    echo "${BLUE}6. ${WHITE}返回主菜单${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-6): ${NC}" choice
    
    case $choice in
        1)
            show_title
            echo "${BLUE}网络连接诊断${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${YELLOW}正在测试网络连接...${NC}"
            
            # 测试DNS解析
            echo "${BLUE}测试DNS解析:${NC}"
            ping -c 1 google.com
            
            # 测试网络延迟
            echo "${BLUE}测试网络延迟:${NC}"
            ping -c 5 google.com | grep avg
            
            # 测试网络速度
            echo "${BLUE}测试网络速度:${NC}"
            if command -v speedtest-cli &> /dev/null; then
                speedtest-cli --simple
            else
                echo "${YELLOW}speedtest-cli 未安装，使用curl测试...${NC}"
                curl -o /dev/null -s -w "%{speed_download}" https://speed.hetzner.de/100MB.bin
                echo " bytes/sec"
            fi
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            problem_diagnosis
            ;;
        2)
            show_title
            echo "${BLUE}磁盘空间检查${NC}"
            echo "${GREEN}=======================================${NC}"
            df -h
            
            # 检查大文件
            echo "${BLUE}=======================================${NC}"
            echo "${YELLOW}最大的10个文件:${NC}"
            find / -type f -exec du -h {} \; 2>/dev/null | sort -hr | head -10
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            problem_diagnosis
            ;;
        3)
            show_title
            echo "${BLUE}内存使用检查${NC}"
            echo "${GREEN}=======================================${NC}"
            free -h
            
            # 检查内存使用最高的进程
            echo "${BLUE}=======================================${NC}"
            echo "${YELLOW}内存使用最高的10个进程:${NC}"
            ps aux --sort=-%mem | head -11
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            problem_diagnosis
            ;;
        4)
            show_title
            echo "${BLUE}系统服务状态${NC}"
            echo "${GREEN}=======================================${NC}"
            
            if command -v systemctl &> /dev/null; then
                systemctl list-units --type=service --state=running | head -20
            elif command -v service &> /dev/null; then
                service --status-all | grep running
            else
                echo "${RED}无法检查服务状态${NC}"
            fi
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            problem_diagnosis
            ;;
        5)
            show_title
            echo "${BLUE}日志检查${NC}"
            echo "${GREEN}=======================================${NC}"
            
            if [ -d "/var/log" ]; then
                echo "${YELLOW}最近的错误日志:${NC}"
                grep -r "ERROR" /var/log/ 2>/dev/null | tail -20
            else
                echo "${RED}日志目录不存在${NC}"
            fi
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            problem_diagnosis
            ;;
        6)
            return
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            problem_diagnosis
            ;;
    esac
}

# 学习资源中心
learning_resources() {
    show_title
    echo "${BLUE}学习资源中心${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}Linux基础教程${NC}"
    echo "${BLUE}2. ${WHITE}命令行快捷键${NC}"
    echo "${BLUE}3. ${WHITE}常见问题解答${NC}"
    echo "${BLUE}4. ${WHITE}学习路径推荐${NC}"
    echo "${BLUE}5. ${WHITE}返回主菜单${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-5): ${NC}" choice
    
    case $choice in
        1)
            show_title
            echo "${BLUE}Linux教程${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${WHITE}1. 基础教程${NC}"
            echo "${WHITE}2. 中级教程${NC}"
            echo "${WHITE}3. 高级教程${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请选择教程级别 (1-3): ${NC}" tutorial_level
            
            case $tutorial_level in
                1)
                    show_title
                    echo "${BLUE}Linux基础教程${NC}"
                    echo "${GREEN}=======================================${NC}"
                    echo "${WHITE}1. Linux系统简介${NC}"
                    echo "${WHITE}2. 命令行基础${NC}"
                    echo "${WHITE}3. 文件系统导航${NC}"
                    echo "${WHITE}4. 文件操作${NC}"
                    echo "${WHITE}5. 系统管理基础${NC}"
                    echo "${GREEN}=======================================${NC}"
                    read -p "${YELLOW}请选择教程 (1-5): ${NC}" basic_choice
                    
                    case $basic_choice in
                        1)
                            echo "${BLUE}Linux系统简介${NC}"
                            echo "${GREEN}=======================================${NC}"
                            echo "Linux是一种自由和开放源代码的操作系统内核，"
                            echo "它是由Linus Torvalds在1991年创建的。"
                            echo "Linux通常与GNU软件一起使用，形成完整的操作系统。"
                            echo "常见的Linux发行版包括Ubuntu、Debian、CentOS、Fedora等。"
                            echo "Linux以其稳定性、安全性和灵活性而闻名。"
                            ;;
                        2)
                            echo "${BLUE}命令行基础${NC}"
                            echo "${GREEN}=======================================${NC}"
                            echo "命令行是与Linux系统交互的主要方式，"
                            echo "它允许你通过输入命令来执行各种任务。"
                            echo "基本命令结构：命令 [选项] [参数]"
                            echo "例如：ls -la /home"
                            echo "按Tab键可以自动补全命令和路径。"
                            ;;
                        3)
                            echo "${BLUE}文件系统导航${NC}"
                            echo "${GREEN}=======================================${NC}"
                            echo "Linux文件系统是一个树状结构，以/为根目录。"
                            echo "常用导航命令："
                            echo "- cd 目录 - 切换到指定目录"
                            echo "- pwd - 显示当前目录"
                            echo "- ls - 列出目录内容"
                            echo "- find - 查找文件和目录"
                            ;;
                        4)
                            echo "${BLUE}文件操作${NC}"
                            echo "${GREEN}=======================================${NC}"
                            echo "常用文件操作命令："
                            echo "- cp - 复制文件和目录"
                            echo "- mv - 移动/重命名文件和目录"
                            echo "- rm - 删除文件和目录"
                            echo "- touch - 创建空文件"
                            echo "- cat - 查看文件内容"
                            echo "- nano/vim - 编辑文件"
                            ;;
                        5)
                            echo "${BLUE}系统管理基础${NC}"
                            echo "${GREEN}=======================================${NC}"
                            echo "常用系统管理命令："
                            echo "- ps - 查看进程"
                            echo "- top - 实时系统监控"
                            echo "- df - 查看磁盘使用情况"
                            echo "- free - 查看内存使用情况"
                            echo "- systemctl - 管理系统服务"
                            ;;
                        *)
                            echo "${RED}无效选择，请重新输入！${NC}"
                            ;;
                    esac
                    ;;
                2)
                    show_title
                    echo "${BLUE}Linux中级教程${NC}"
                    echo "${GREEN}=======================================${NC}"
                    echo "${WHITE}1. 用户和权限管理${NC}"
                    echo "${WHITE}2. 软件包管理${NC}"
                    echo "${WHITE}3. 网络配置${NC}"
                    echo "${WHITE}4. 服务管理${NC}"
                    echo "${WHITE}5. Shell脚本基础${NC}"
                    echo "${GREEN}=======================================${NC}"
                    read -p "${YELLOW}请选择教程 (1-5): ${NC}" intermediate_choice
                    
                    case $intermediate_choice in
                        1)
                            echo "${BLUE}用户和权限管理${NC}"
                            echo "${GREEN}=======================================${NC}"
                            echo "用户管理命令："
                            echo "- useradd - 创建新用户"
                            echo "- passwd - 设置用户密码"
                            echo "- usermod - 修改用户属性"
                            echo "- userdel - 删除用户"
                            echo "权限管理命令："
                            echo "- chmod - 修改文件权限"
                            echo "- chown - 修改文件所有者"
                            echo "- chgrp - 修改文件所属组"
                            ;;
                        2)
                            echo "${BLUE}软件包管理${NC}"
                            echo "${GREEN}=======================================${NC}"
                            echo "Debian/Ubuntu (apt):"
                            echo "- apt update - 更新软件包列表"
                            echo "- apt install - 安装软件包"
                            echo "- apt remove - 卸载软件包"
                            echo "- apt upgrade - 更新已安装软件包"
                            echo "CentOS/RHEL (yum/dnf):"
                            echo "- yum install - 安装软件包"
                            echo "- yum remove - 卸载软件包"
                            echo "- yum update - 更新软件包"
                            ;;
                        3)
                            echo "${BLUE}网络配置${NC}"
                            echo "${GREEN}=======================================${NC}"
                            echo "网络配置命令："
                            echo "- ifconfig - 查看网络接口信息"
                            echo "- ip addr - 查看IP地址"
                            echo "- ping - 测试网络连接"
                            echo "- netstat - 查看网络状态"
                            echo "- ss - 查看网络连接状态"
                            ;;
                        4)
                            echo "${BLUE}服务管理${NC}"
                            echo "${GREEN}=======================================${NC}"
                            echo "systemd服务管理："
                            echo "- systemctl start - 启动服务"
                            echo "- systemctl stop - 停止服务"
                            echo "- systemctl restart - 重启服务"
                            echo "- systemctl status - 查看服务状态"
                            echo "- systemctl enable - 设置服务开机自启"
                            ;;
                        5)
                            echo "${BLUE}Shell脚本基础${NC}"
                            echo "${GREEN}=======================================${NC}"
                            echo "Shell脚本基本结构："
                            echo "- #!/bin/bash - 指定解释器"
                            echo "- 变量定义：variable=value"
                            echo "- 条件判断：if [ condition ]; then...fi"
                            echo "- 循环：for, while, until"
                            echo "- 函数定义：function_name() {...}"
                            ;;
                        *)
                            echo "${RED}无效选择，请重新输入！${NC}"
                            ;;
                    esac
                    ;;
                3)
                    show_title
                    echo "${BLUE}Linux高级教程${NC}"
                    echo "${GREEN}=======================================${NC}"
                    echo "${WHITE}1. 系统性能优化${NC}"
                    echo "${WHITE}2. 安全加固${NC}"
                    echo "${WHITE}3. 磁盘管理${NC}"
                    echo "${WHITE}4. 网络服务配置${NC}"
                    echo "${WHITE}5. 高级Shell脚本${NC}"
                    echo "${GREEN}=======================================${NC}"
                    read -p "${YELLOW}请选择教程 (1-5): ${NC}" advanced_choice
                    
                    case $advanced_choice in
                        1)
                            echo "${BLUE}系统性能优化${NC}"
                            echo "${GREEN}=======================================${NC}"
                            echo "性能优化方法："
                            echo "- 调整内核参数：sysctl"
                            echo "- 优化内存使用：vm.swappiness"
                            echo "- 调整文件系统：noatime"
                            echo "- 优化网络：TCP参数调整"
                            echo "- 使用工具：top, htop, iostat, vmstat"
                            ;;
                        2)
                            echo "${BLUE}安全加固${NC}"
                            echo "${GREEN}=======================================${NC}"
                            echo "安全加固措施："
                            echo "- 防火墙配置：iptables, firewalld"
                            echo "- SSH安全：禁用root登录，使用密钥认证"
                            echo "- 权限管理：最小权限原则"
                            echo "- 定期更新：yum update, apt update"
                            echo "- 安全审计：auditd"
                            ;;
                        3)
                            echo "${BLUE}磁盘管理${NC}"
                            echo "${GREEN}=======================================${NC}"
                            echo "磁盘管理命令："
                            echo "- fdisk - 分区管理"
                            echo "- mkfs - 创建文件系统"
                            echo "- mount - 挂载文件系统"
                            echo "- lvm - 逻辑卷管理"
                            echo "- raid - 磁盘阵列"
                            ;;
                        4)
                            echo "${BLUE}网络服务配置${NC}"
                            echo "${GREEN}=======================================${NC}"
                            echo "常见网络服务："
                            echo "- Apache/Nginx - Web服务器"
                            echo "- MySQL/PostgreSQL - 数据库"
                            echo "- SSH - 远程登录"
                            echo "- FTP/SFTP - 文件传输"
                            echo "- DNS - 域名解析"
                            ;;
                        5)
                            echo "${BLUE}高级Shell脚本${NC}"
                            echo "${GREEN}=======================================${NC}"
                            echo "高级Shell脚本特性："
                            echo "- 命令行参数处理：$1, $2, $@"
                            echo "- 输入输出重定向：>, <, >>"
                            echo "- 管道：|"
                            echo "- 正则表达式：grep, sed, awk"
                            echo "- 错误处理：trap, set -e"
                            ;;
                        *)
                            echo "${RED}无效选择，请重新输入！${NC}"
                            ;;
                    esac
                    ;;
                *)
                    echo "${RED}无效选择，请重新输入！${NC}"
                    ;;
            esac
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            learning_resources
            ;;
        2)
            show_title
            echo "${BLUE}命令行快捷键${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${WHITE}Tab${NC} - 自动补全命令和路径"
            echo "${WHITE}Ctrl+C${NC} - 终止当前命令"
            echo "${WHITE}Ctrl+L${NC} - 清屏"
            echo "${WHITE}Ctrl+D${NC} - 退出终端"
            echo "${WHITE}↑↓${NC} - 浏览历史命令"
            echo "${WHITE}Ctrl+R${NC} - 搜索历史命令"
            echo "${WHITE}Ctrl+A${NC} - 移动到命令行开头"
            echo "${WHITE}Ctrl+E${NC} - 移动到命令行结尾"
            echo "${WHITE}Ctrl+U${NC} - 清除命令行内容"
            echo "${WHITE}Ctrl+K${NC} - 清除从光标到行尾的内容"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}按Enter键返回...${NC}"
            learning_resources
            ;;
        3)
            show_title
            echo "${BLUE}常见问题解答${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${WHITE}Q: 如何复制文件？${NC}"
            echo "${YELLOW}A: 使用 cp 命令，例如: cp file1 file2${NC}"
            echo "${WHITE}Q: 如何删除文件？${NC}"
            echo "${YELLOW}A: 使用 rm 命令，例如: rm file${NC}"
            echo "${WHITE}Q: 如何查看文件内容？${NC}"
            echo "${YELLOW}A: 使用 cat、less 或 more 命令${NC}"
            echo "${WHITE}Q: 如何创建目录？${NC}"
            echo "${YELLOW}A: 使用 mkdir 命令，例如: mkdir dir${NC}"
            echo "${WHITE}Q: 如何查看系统信息？${NC}"
            echo "${YELLOW}A: 使用 uname -a 命令${NC}"
            echo "${WHITE}Q: 如何查看磁盘使用情况？${NC}"
            echo "${YELLOW}A: 使用 df -h 命令${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}按Enter键返回...${NC}"
            learning_resources
            ;;
        4)
            show_title
            echo "${BLUE}学习路径推荐${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${YELLOW}Linux学习路径：${NC}"
            echo "1. ${WHITE}基础阶段：了解Linux基本概念和命令${NC}"
            echo "2. ${WHITE}中级阶段：学习文件系统、用户管理、权限管理${NC}"
            echo "3. ${WHITE}高级阶段：学习系统管理、网络配置、服务管理${NC}"
            echo "4. ${WHITE}专业阶段：学习Shell脚本、服务器配置、安全管理${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${YELLOW}推荐学习资源：${NC}"
            echo "- ${WHITE}Linux命令行基础教程${NC}"
            echo "- ${WHITE}鸟哥的Linux私房菜${NC}"
            echo "- ${WHITE}Linux从入门到精通${NC}"
            echo "- ${WHITE}Linux系统管理实战${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}按Enter键返回...${NC}"
            learning_resources
            ;;
        5)
            return
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            learning_resources
            ;;
    esac
}

# 任务自动化工具
task_automation() {
    show_title
    echo "${BLUE}任务自动化工具${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}创建简单脚本${NC}"
    echo "${BLUE}2. ${WHITE}设置定时任务${NC}"
    echo "${BLUE}3. ${WHITE}查看现有定时任务${NC}"
    echo "${BLUE}4. ${WHITE}返回主菜单${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-4): ${NC}" choice
    
    case $choice in
        1)
            show_title
            echo "${BLUE}创建简单脚本${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请输入脚本名称: ${NC}" script_name
            
            cat > "$script_name.sh" << 'EOF'
#!/bin/bash

# 自动生成的脚本

echo "Hello, World!"
echo "当前日期: $(date)"
echo "当前目录: $(pwd)"
echo "当前用户: $(whoami)"
EOF
            
            chmod +x "$script_name.sh"
            echo "${GREEN}脚本创建成功！${NC}"
            echo "${YELLOW}脚本内容:${NC}"
            cat "$script_name.sh"
            echo "${GREEN}=======================================${NC}"
            echo "${YELLOW}运行脚本: ./$script_name.sh${NC}"
            sleep 2
            task_automation
            ;;
        2)
            show_title
            echo "${BLUE}设置定时任务${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${YELLOW}请输入定时任务的执行时间和命令${NC}"
            echo "${WHITE}格式: 分 时 日 月 周 命令${NC}"
            echo "${WHITE}例如: 0 12 * * * echo 'Hello' >> /tmp/test.txt${NC}"
            read -p "${YELLOW}请输入定时任务: ${NC}" cron_job
            
            echo "$cron_job" | crontab -
            if [ $? -eq 0 ]; then
                echo "${GREEN}定时任务设置成功！${NC}"
            else
                echo "${RED}定时任务设置失败，请检查格式${NC}"
            fi
            sleep 2
            task_automation
            ;;
        3)
            show_title
            echo "${BLUE}查看现有定时任务${NC}"
            echo "${GREEN}=======================================${NC}"
            crontab -l
            
            if [ $? -ne 0 ]; then
                echo "${YELLOW}没有设置定时任务${NC}"
            fi
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            task_automation
            ;;
        4)
            return
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            task_automation
            ;;
    esac
}

# 系统维护工具
system_maintenance() {
    show_title
    echo "${BLUE}系统维护工具${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}清理系统垃圾${NC}"
    echo "${BLUE}2. ${WHITE}更新系统${NC}"
    echo "${BLUE}3. ${WHITE}检查系统健康状态${NC}"
    echo "${BLUE}4. ${WHITE}备份系统配置${NC}"
    echo "${BLUE}5. ${WHITE}返回主菜单${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-5): ${NC}" choice
    
    case $choice in
        1)
            show_title
            echo "${BLUE}清理系统垃圾${NC}"
            echo "${GREEN}=======================================${NC}"
            
            local package_manager=$(detect_package_manager)
            echo "${YELLOW}正在清理系统垃圾...${NC}"
            
            case $package_manager in
                "apt")
                    sudo apt autoclean
                    sudo apt autoremove -y
                    ;;
                "yum")
                    sudo yum clean all
                    ;;
                "dnf")
                    sudo dnf clean all
                    ;;
                "pacman")
                    sudo pacman -Sc --noconfirm
                    ;;
                "zypper")
                    sudo zypper clean
                    ;;
                *)
                    echo "${YELLOW}清理临时文件...${NC}"
                    sudo rm -rf /tmp/*
                    ;;
            esac
            
            echo "${GREEN}清理完成！${NC}"
            sleep 2
            system_maintenance
            ;;
        2)
            show_title
            echo "${BLUE}更新系统${NC}"
            echo "${GREEN}=======================================${NC}"
            
            local package_manager=$(detect_package_manager)
            echo "${YELLOW}正在更新系统...${NC}"
            
            case $package_manager in
                "apt")
                    sudo apt update && sudo apt upgrade -y
                    ;;
                "yum")
                    sudo yum update -y
                    ;;
                "dnf")
                    sudo dnf update -y
                    ;;
                "pacman")
                    sudo pacman -Syu --noconfirm
                    ;;
                "zypper")
                    sudo zypper update -y
                    ;;
                *)
                    echo "${RED}无法自动更新系统，请手动更新${NC}"
                    ;;
            esac
            
            if [ $? -eq 0 ]; then
                echo "${GREEN}更新完成！${NC}"
            else
                echo "${RED}更新失败，请检查网络连接${NC}"
            fi
            sleep 2
            system_maintenance
            ;;
        3)
            show_title
            echo "${BLUE}检查系统健康状态${NC}"
            echo "${GREEN}=======================================${NC}"
            
            # 检查磁盘健康
            echo "${BLUE}磁盘健康状态:${NC}"
            if command -v smartctl &> /dev/null; then
                sudo smartctl -a /dev/sda 2>/dev/null | grep -E "SMART overall|Health"
            else
                echo "${YELLOW}smartctl 未安装${NC}"
            fi
            
            # 检查系统负载
            echo "${BLUE}系统负载:${NC}"
            uptime
            
            # 检查内存使用
            echo "${BLUE}内存使用:${NC}"
            free -h
            
            # 检查磁盘空间
            echo "${BLUE}磁盘空间:${NC}"
            df -h
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            system_maintenance
            ;;
        4)
            show_title
            echo "${BLUE}备份系统配置${NC}"
            echo "${GREEN}=======================================${NC}"
            
            local backup_dir="backup_$(date +%Y%m%d_%H%M%S)"
            mkdir -p "$backup_dir"
            
            # 备份重要配置文件
            echo "${YELLOW}正在备份系统配置...${NC}"
            
            if [ -f "/etc/fstab" ]; then
                cp /etc/fstab "$backup_dir/"
            fi
            
            if [ -f "/etc/network/interfaces" ]; then
                cp /etc/network/interfaces "$backup_dir/"
            fi
            
            if [ -f "/etc/resolv.conf" ]; then
                cp /etc/resolv.conf "$backup_dir/"
            fi
            
            if [ -f "~/.bashrc" ]; then
                cp ~/.bashrc "$backup_dir/"
            fi
            
            # 压缩备份
            tar -czf "$backup_dir.tar.gz" "$backup_dir"
            rm -rf "$backup_dir"
            
            echo "${GREEN}备份完成！${NC}"
            echo "${YELLOW}备份文件: ${WHITE}$backup_dir.tar.gz${NC}"
            sleep 2
            system_maintenance
            ;;
        5)
            return
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            system_maintenance
            ;;
    esac
}

# 主菜单
show_main_menu() {
    show_title
    echo "${BLUE}1. ${WHITE}软件包管理${NC}"
    echo "${BLUE}2. ${WHITE}系统配置向导${NC}"
    echo "${BLUE}3. ${WHITE}问题诊断工具${NC}"
    echo "${BLUE}4. ${WHITE}学习资源中心${NC}"
    echo "${BLUE}5. ${WHITE}任务自动化${NC}"
    echo "${BLUE}6. ${WHITE}系统维护工具${NC}"
    echo "${BLUE}7. ${WHITE}返回主菜单${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-7): ${NC}" choice
    
    case $choice in
        1)
            package_manager
            show_main_menu
            ;;
        2)
            system_config_wizard
            show_main_menu
            ;;
        3)
            problem_diagnosis
            show_main_menu
            ;;
        4)
            learning_resources
            show_main_menu
            ;;
        5)
            task_automation
            show_main_menu
            ;;
        6)
            system_maintenance
            show_main_menu
            ;;
        7)
            return
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            show_main_menu
            ;;
    esac
}

# 启动新用户助手
show_main_menu