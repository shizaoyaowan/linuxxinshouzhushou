#!/bin/bash

# 加载语言系统
if [ -f "f:\\linuxminglinghang\\lang_system.sh" ]; then
    source "f:\\linuxminglinghang\\lang_system.sh"
    init_lang_system
else
    # 默认语言为中文
    CURRENT_LANG="zh"
fi

# 加载配置文件
if [ -f "f:\\linuxminglinghang\\config.sh" ]; then
    source "f:\\linuxminglinghang\\config.sh"
else
    # 默认颜色定义
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[0;33m'
    BLUE='\033[0;34m'
    PURPLE='\033[0;35m'
    CYAN='\033[0;36m'
    WHITE='\033[0;37m'
    NC='\033[0m' # No Color
fi

# 清屏函数
clear_screen() {
    clear
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

# 检查键盘快捷键支持
check_keyboard_support() {
    if command -v readline > /dev/null 2>&1; then
        KEYBOARD_SUPPORT=true
    else
        KEYBOARD_SUPPORT=false
    fi
}

# 简单文本编辑器
simple_editor() {
    local file=$1
    
    if [ ! -f "$file" ]; then
        touch "$file"
    fi
    
    clear_screen
    echo "${GREEN}=======================================${NC}"
    echo "${YELLOW}        简单文本编辑器${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}编辑文件: ${WHITE}$file${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${YELLOW}请输入内容，按 Ctrl+D 保存并退出${NC}"
    echo "${GREEN}=======================================${NC}"
    
    # 备份原文件
    cp "$file" "$file.bak" 2>/dev/null
    
    # 读取用户输入并写入文件
    cat > "$file"
    
    echo "${GREEN}文件保存成功！${NC}"
    sleep 2
}

# 显示标题
show_title() {
    clear_screen
    echo "${GREEN}=======================================${NC}"
    echo "${YELLOW}        Linux新手开荒助手${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}专为新手设计，无需记住命令${NC}"
    echo "${GREEN}=======================================${NC}"
}

# 主菜单
show_main_menu() {
    show_title
    echo "${BLUE}1. ${WHITE}文件管理${NC}"
    echo "${BLUE}2. ${WHITE}系统监测${NC}"
    echo "${BLUE}3. ${WHITE}网络工具${NC}"
    echo "${BLUE}4. ${WHITE}系统信息${NC}"
    echo "${BLUE}5. ${WHITE}常用工具${NC}"
    echo "${BLUE}6. ${WHITE}帮助指南${NC}"
    echo "${BLUE}7. ${WHITE}用户配置${NC}"
    echo "${BLUE}8. ${WHITE}新用户助手${NC}"
    echo "${BLUE}9. ${WHITE}高级功能模块${NC}"
    echo "${BLUE}10. ${WHITE}性能优化${NC}"
    echo "${BLUE}11. ${WHITE}学习报告${NC}"
    echo "${BLUE}12. ${WHITE}语言选择${NC}"
    echo "${BLUE}13. ${WHITE}退出${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${YELLOW}提示: 可以使用键盘数字键选择操作${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-13): ${NC}" choice
    
    case $choice in
        1)
            file_management
            ;;
        2)
            system_monitoring
            ;;
        3)
            network_tools
            ;;
        4)
            system_info
            ;;
        5)
            common_tools
            ;;
        6)
            help_guide
            ;;
        7)
            if [ -f "f:\\linuxminglinghang\\config.sh" ]; then
                source "f:\\linuxminglinghang\\config.sh"
                show_config_menu
            else
                echo "${RED}配置文件不存在！${NC}"
                sleep 2
            fi
            show_main_menu
            ;;
        8)
            if [ -f "f:\\linuxminglinghang\\newuser.sh" ]; then
                bash "f:\\linuxminglinghang\\newuser.sh"
            else
                echo "${RED}新用户助手文件不存在！${NC}"
                sleep 2
            fi
            show_main_menu
            ;;
        9)
            if [ -f "f:\linuxminglinghang\advanced_tools.sh" ]; then
                bash "f:\linuxminglinghang\advanced_tools.sh"
            else
                echo "${RED}高级功能模块文件不存在！${NC}"
                sleep 2
                show_main_menu
            fi
            ;;
        10)
            if [ -f "f:\linuxminglinghang\optimize.sh" ]; then
                bash "f:\linuxminglinghang\optimize.sh"
            else
                echo "${RED}性能优化文件不存在！${NC}"
                sleep 2
                show_main_menu
            fi
            ;;
        11)
            if [ -f "f:\linuxminglinghang\learning_report.sh" ]; then
                bash "f:\linuxminglinghang\learning_report.sh"
            else
                echo "${RED}学习报告生成工具文件不存在！${NC}"
                sleep 2
                show_main_menu
            fi
            ;;
        12)
            if [ -f "f:\linuxminglinghang\lang_system.sh" ]; then
                source "f:\linuxminglinghang\lang_system.sh"
                show_language_menu
            else
                echo "${RED}语言系统文件不存在！${NC}"
                sleep 2
            fi
            show_main_menu
            ;;
        13)
            echo "${GREEN}感谢使用Linux新手开荒助手！${NC}"
            exit 0
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            show_main_menu
            ;;
    esac
}

# 文件管理菜单
file_management() {
    show_title
    echo "${BLUE}文件管理${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}浏览文件和目录${NC}"
    echo "${BLUE}2. ${WHITE}创建新文件${NC}"
    echo "${BLUE}3. ${WHITE}创建新目录${NC}"
    echo "${BLUE}4. ${WHITE}复制文件/目录${NC}"
    echo "${BLUE}5. ${WHITE}移动文件/目录${NC}"
    echo "${BLUE}6. ${WHITE}删除文件/目录${NC}"
    echo "${BLUE}7. ${WHITE}查看文件内容${NC}"
    echo "${BLUE}8. ${WHITE}编辑文件${NC}"
    echo "${BLUE}9. ${WHITE}搜索文件${NC}"
    echo "${BLUE}10. ${WHITE}返回主菜单${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-10): ${NC}" choice
    
    case $choice in
        1)
            browse_files
            ;;
        2)
            create_file
            ;;
        3)
            create_directory
            ;;
        4)
            copy_file
            ;;
        5)
            move_file
            ;;
        6)
            delete_file
            ;;
        7)
            view_file
            ;;
        8)
            edit_file
            ;;
        9)
            search_file
            ;;
        10)
            show_main_menu
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            file_management
            ;;
    esac
}

# 浏览文件和目录
browse_files() {
    show_title
    echo "${BLUE}浏览文件和目录${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${YELLOW}当前目录: $(pwd)${NC}"
    echo "${GREEN}=======================================${NC}"
    
    # 列出当前目录内容
    local i=1
    local items=()
    
    # 添加返回上一级选项
    echo "${BLUE}0. ${WHITE}[返回上一级]${NC}"
    items[0]=".."
    
    # 列出文件和目录
    for item in *; do
        if [ -d "$item" ]; then
            echo "${BLUE}$i. ${CYAN}[目录] ${WHITE}$item${NC}"
        else
            echo "${BLUE}$i. ${WHITE}$item${NC}"
        fi
        items[$i]="$item"
        i=$((i+1))
    done
    
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}99. ${WHITE}返回文件管理菜单${NC}"
    read -p "${YELLOW}请选择要查看的项目: ${NC}" choice
    
    if [ "$choice" = "99" ]; then
        file_management
    elif [ "$choice" -ge 0 ] && [ "$choice" -lt $i ]; then
        selected_item=${items[$choice]}
        if [ -d "$selected_item" ]; then
            cd "$selected_item"
            browse_files
        else
            # 查看文件内容
            show_title
            echo "${BLUE}文件内容: ${WHITE}$selected_item${NC}"
            echo "${GREEN}=======================================${NC}"
            cat "$selected_item"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}按Enter键返回...${NC}"
            browse_files
        fi
    else
        echo "${RED}无效选择，请重新输入！${NC}"
        sleep 2
        browse_files
    fi
}

# 创建新文件
create_file() {
    show_title
    echo "${BLUE}创建新文件${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请输入文件名: ${NC}" file_name
    
    if [ -f "$file_name" ]; then
        echo "${RED}文件已存在！${NC}"
        sleep 2
        file_management
    else
        touch "$file_name"
        echo "${GREEN}文件创建成功！${NC}"
        sleep 2
        file_management
    fi
}

# 创建新目录
create_directory() {
    show_title
    echo "${BLUE}创建新目录${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请输入目录名: ${NC}" dir_name
    
    if [ -d "$dir_name" ]; then
        echo "${RED}目录已存在！${NC}"
        sleep 2
        file_management
    else
        mkdir -p "$dir_name"
        echo "${GREEN}目录创建成功！${NC}"
        sleep 2
        file_management
    fi
}

# 复制文件/目录
copy_file() {
    show_title
    echo "${BLUE}复制文件/目录${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请输入要复制的文件/目录: ${NC}" source
    read -p "${YELLOW}请输入目标位置: ${NC}" destination
    
    if [ ! -e "$source" ]; then
        echo "${RED}源文件/目录不存在！${NC}"
        sleep 2
        file_management
    else
        cp -r "$source" "$destination"
        echo "${GREEN}复制成功！${NC}"
        sleep 2
        file_management
    fi
}

# 移动文件/目录
move_file() {
    show_title
    echo "${BLUE}移动文件/目录${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请输入要移动的文件/目录: ${NC}" source
    read -p "${YELLOW}请输入目标位置: ${NC}" destination
    
    if [ ! -e "$source" ]; then
        echo "${RED}源文件/目录不存在！${NC}"
        sleep 2
        file_management
    else
        mv "$source" "$destination"
        echo "${GREEN}移动成功！${NC}"
        sleep 2
        file_management
    fi
}

# 删除文件/目录
delete_file() {
    show_title
    echo "${BLUE}删除文件/目录${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请输入要删除的文件/目录: ${NC}" target
    
    if [ ! -e "$target" ]; then
        echo "${RED}文件/目录不存在！${NC}"
        sleep 2
        file_management
    else
        read -p "${RED}确定要删除 $target 吗？(y/n): ${NC}" confirm
        if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
            rm -rf "$target"
            echo "${GREEN}删除成功！${NC}"
        else
            echo "${YELLOW}取消删除${NC}"
        fi
        sleep 2
        file_management
    fi
}

# 查看文件内容
view_file() {
    show_title
    echo "${BLUE}查看文件内容${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请输入要查看的文件: ${NC}" file
    
    if [ ! -f "$file" ]; then
        echo "${RED}文件不存在！${NC}"
        sleep 2
        file_management
    else
        show_title
        echo "${BLUE}文件内容: ${WHITE}$file${NC}"
        echo "${GREEN}=======================================${NC}"
        cat "$file"
        echo "${GREEN}=======================================${NC}"
        read -p "${YELLOW}按Enter键返回...${NC}"
        file_management
    fi
}

# 编辑文件
edit_file() {
    show_title
    echo "${BLUE}编辑文件${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请输入要编辑的文件: ${NC}" file
    
    simple_editor "$file"
    file_management
}

# 搜索文件
search_file() {
    show_title
    echo "${BLUE}搜索文件${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请输入搜索关键词: ${NC}" keyword
    
    show_title
    echo "${BLUE}搜索结果:${NC}"
    echo "${GREEN}=======================================${NC}"
    find . -name "*$keyword*" | head -20
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}按Enter键返回...${NC}"
    file_management
}

# 系统监测菜单
system_monitoring() {
    show_title
    echo "${BLUE}系统监测${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}CPU使用情况${NC}"
    echo "${BLUE}2. ${WHITE}内存使用情况${NC}"
    echo "${BLUE}3. ${WHITE}磁盘使用情况${NC}"
    echo "${BLUE}4. ${WHITE}进程信息${NC}"
    echo "${BLUE}5. ${WHITE}进程管理${NC}"
    echo "${BLUE}6. ${WHITE}系统负载${NC}"
    echo "${BLUE}7. ${WHITE}网络状态${NC}"
    echo "${BLUE}8. ${WHITE}实时系统图表${NC}"
    echo "${BLUE}9. ${WHITE}完整系统监测${NC}"
    echo "${BLUE}10. ${WHITE}返回主菜单${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-10): ${NC}" choice
    
    case $choice in
        1)
            show_cpu_usage
            ;;
        2)
            show_memory_usage
            ;;
        3)
            show_disk_usage
            ;;
        4)
            show_processes
            ;;
        5)
            manage_processes
            ;;
        6)
            show_system_load
            ;;
        7)
            show_network_status
            ;;
        8)
            real_time_chart
            ;;
        9)
            full_system_monitoring
            ;;
        10)
            show_main_menu
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            system_monitoring
            ;;
    esac
}

# 显示CPU使用情况
show_cpu_usage() {
    show_title
    echo "${BLUE}CPU使用情况${NC}"
    echo "${GREEN}=======================================${NC}"
    if command -v mpstat &> /dev/null; then
        mpstat 1 1
    else
        top -bn1 | grep "Cpu(s)"
    fi
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}按Enter键返回...${NC}"
    system_monitoring
}

# 显示内存使用情况
show_memory_usage() {
    show_title
    echo "${BLUE}内存使用情况${NC}"
    echo "${GREEN}=======================================${NC}"
    free -h
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}按Enter键返回...${NC}"
    system_monitoring
}

# 显示磁盘使用情况
show_disk_usage() {
    show_title
    echo "${BLUE}磁盘使用情况${NC}"
    echo "${GREEN}=======================================${NC}"
    df -h
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}按Enter键返回...${NC}"
    system_monitoring
}

# 显示进程信息
show_processes() {
    show_title
    echo "${BLUE}进程信息${NC}"
    echo "${GREEN}=======================================${NC}"
    ps aux --sort=-%cpu | head -11
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}按Enter键返回...${NC}"
    system_monitoring
}

# 显示系统负载
show_system_load() {
    show_title
    echo "${BLUE}系统负载${NC}"
    echo "${GREEN}=======================================${NC}"
    uptime
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}按Enter键返回...${NC}"
    system_monitoring
}

# 显示网络状态
show_network_status() {
    show_title
    echo "${BLUE}网络状态${NC}"
    echo "${GREEN}=======================================${NC}"
    if command -v netstat &> /dev/null; then
        netstat -tuln | head -20
    elif command -v ss &> /dev/null; then
        ss -tuln | head -20
    else
        echo "网络状态命令未安装"
    fi
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}按Enter键返回...${NC}"
    system_monitoring
}

# 完整系统监测
full_system_monitoring() {
    show_title
    echo "${BLUE}完整系统监测${NC}"
    echo "${GREEN}=======================================${NC}"
    
    # 系统信息
    echo "${BLUE}系统信息:${NC}"
    uname -a
    echo
    
    # CPU信息
    echo "${BLUE}CPU使用情况:${NC}"
    if command -v mpstat &> /dev/null; then
        mpstat 1 1
    else
        top -bn1 | grep "Cpu(s)"
    fi
    echo
    
    # 内存使用情况
    echo "${BLUE}内存使用情况:${NC}"
    free -h
    echo
    
    # 磁盘使用情况
    echo "${BLUE}磁盘使用情况:${NC}"
    df -h
    echo
    
    # 系统负载
    echo "${BLUE}系统负载:${NC}"
    uptime
    echo
    
    # 进程信息
    echo "${BLUE}进程信息 (前5个占用CPU最多的进程):${NC}"
    ps aux --sort=-%cpu | head -6
    echo
    
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}按Enter键返回...${NC}"
    system_monitoring
}

# 进程管理
manage_processes() {
    show_title
    echo "${BLUE}进程管理${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}查看所有进程${NC}"
    echo "${BLUE}2. ${WHITE}终止进程${NC}"
    echo "${BLUE}3. ${WHITE}搜索进程${NC}"
    echo "${BLUE}4. ${WHITE}返回系统监测菜单${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-4): ${NC}" choice
    
    case $choice in
        1)
            show_title
            echo "${BLUE}所有进程${NC}"
            echo "${GREEN}=======================================${NC}"
            ps aux | head -20
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}按Enter键返回...${NC}"
            manage_processes
            ;;
        2)
            show_title
            echo "${BLUE}终止进程${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请输入要终止的进程ID: ${NC}" pid
            if [ -n "$pid" ] && [ "$pid" -eq "$pid" ] 2>/dev/null; then
                read -p "${RED}确定要终止进程 $pid 吗？(y/n): ${NC}" confirm
                if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
                    kill -9 "$pid" 2>/dev/null
                    if [ $? -eq 0 ]; then
                        echo "${GREEN}进程 $pid 已终止！${NC}"
                    else
                        echo "${RED}终止进程失败，请检查进程ID是否正确！${NC}"
                    fi
                else
                    echo "${YELLOW}取消操作${NC}"
                fi
            else
                echo "${RED}无效的进程ID！${NC}"
            fi
            sleep 2
            manage_processes
            ;;
        3)
            show_title
            echo "${BLUE}搜索进程${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请输入要搜索的进程名称: ${NC}" name
            ps aux | grep "$name" | grep -v grep
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}按Enter键返回...${NC}"
            manage_processes
            ;;
        4)
            system_monitoring
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            manage_processes
            ;;
    esac
}

# 实时系统图表
real_time_chart() {
    show_title
    echo "${BLUE}实时系统图表${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${YELLOW}实时CPU和内存使用情况${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${YELLOW}按 Ctrl+C 退出${NC}"
    
    # 简单的实时监控
    if command -v top &> /dev/null; then
        top -b -d 1 | head -20
    else
        echo "${RED}top 命令未安装${NC}"
    fi
    
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}按Enter键返回...${NC}"
    system_monitoring
}

# 网络工具菜单
network_tools() {
    show_title
    echo "${BLUE}网络工具${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}测试网络连接${NC}"
    echo "${BLUE}2. ${WHITE}查看IP地址${NC}"
    echo "${BLUE}3. ${WHITE}下载文件${NC}"
    echo "${BLUE}4. ${WHITE}网络速度测试${NC}"
    echo "${BLUE}5. ${WHITE}网络配置${NC}"
    echo "${BLUE}6. ${WHITE}返回主菜单${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-6): ${NC}" choice
    
    case $choice in
        1)
            test_network
            ;;
        2)
            show_ip_address
            ;;
        3)
            download_file
            ;;
        4)
            network_speed_test
            ;;
        5)
            network_config
            ;;
        6)
            show_main_menu
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            network_tools
            ;;
    esac
}

# 测试网络连接
test_network() {
    show_title
    echo "${BLUE}测试网络连接${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请输入要测试的网站地址 (例如: google.com): ${NC}" website
    
    echo "${YELLOW}正在测试与 $website 的连接...${NC}"
    ping -c 4 "$website"
    
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}按Enter键返回...${NC}"
    network_tools
}

# 查看IP地址
show_ip_address() {
    show_title
    echo "${BLUE}查看IP地址${NC}"
    echo "${GREEN}=======================================${NC}"
    
    if command -v ifconfig &> /dev/null; then
        ifconfig
    elif command -v ip &> /dev/null; then
        ip addr
    else
        echo "网络命令未安装"
    fi
    
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}按Enter键返回...${NC}"
    network_tools
}

# 下载文件
download_file() {
    show_title
    echo "${BLUE}下载文件${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请输入文件下载地址: ${NC}" url
    read -p "${YELLOW}请输入保存文件名: ${NC}" filename
    
    if command -v wget &> /dev/null; then
        wget -O "$filename" "$url"
    elif command -v curl &> /dev/null; then
        curl -o "$filename" "$url"
    else
        echo "下载工具未安装"
    fi
    
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}按Enter键返回...${NC}"
    network_tools
}

# 网络速度测试
network_speed_test() {
    show_title
    echo "${BLUE}网络速度测试${NC}"
    echo "${GREEN}=======================================${NC}"
    
    if command -v speedtest-cli &> /dev/null; then
        speedtest-cli
    elif command -v curl &> /dev/null; then
        echo "${YELLOW}使用curl测试网络速度...${NC}"
        echo "${BLUE}下载速度测试:${NC}"
        curl -o /dev/null -s -w "%{speed_download}" https://speed.hetzner.de/100MB.bin
        echo " bytes/sec"
        echo "${BLUE}延迟测试:${NC}"
        curl -o /dev/null -s -w "%{time_total}" https://www.google.com
        echo " seconds"
    else
        echo "${RED}无法进行网络速度测试，请安装speedtest-cli或curl${NC}"
    fi
    
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}按Enter键返回...${NC}"
    network_tools
}

# 网络配置
network_config() {
    show_title
    echo "${BLUE}网络配置${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}查看网络接口${NC}"
    echo "${BLUE}2. ${WHITE}查看路由表${NC}"
    echo "${BLUE}3. ${WHITE}查看DNS配置${NC}"
    echo "${BLUE}4. ${WHITE}返回网络工具菜单${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-4): ${NC}" choice
    
    case $choice in
        1)
            show_title
            echo "${BLUE}网络接口${NC}"
            echo "${GREEN}=======================================${NC}"
            if command -v ifconfig &> /dev/null; then
                ifconfig
            elif command -v ip &> /dev/null; then
                ip addr
            else
                echo "${RED}网络命令未安装${NC}"
            fi
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}按Enter键返回...${NC}"
            network_config
            ;;
        2)
            show_title
            echo "${BLUE}路由表${NC}"
            echo "${GREEN}=======================================${NC}"
            if command -v route &> /dev/null; then
                route -n
            elif command -v ip &> /dev/null; then
                ip route
            else
                echo "${RED}路由命令未安装${NC}"
            fi
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}按Enter键返回...${NC}"
            network_config
            ;;
        3)
            show_title
            echo "${BLUE}DNS配置${NC}"
            echo "${GREEN}=======================================${NC}"
            if [ -f "/etc/resolv.conf" ]; then
                cat /etc/resolv.conf
            else
                echo "${RED}DNS配置文件不存在${NC}"
            fi
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}按Enter键返回...${NC}"
            network_config
            ;;
        4)
            network_tools
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            network_config
            ;;
    esac
}

# 系统信息菜单
system_info() {
    show_title
    echo "${BLUE}系统信息${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}系统版本信息${NC}"
    echo "${BLUE}2. ${WHITE}硬件信息${NC}"
    echo "${BLUE}3. ${WHITE}当前用户信息${NC}"
    echo "${BLUE}4. ${WHITE}开机时间${NC}"
    echo "${BLUE}5. ${WHITE}返回主菜单${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-5): ${NC}" choice
    
    case $choice in
        1)
            show_system_version
            ;;
        2)
            show_hardware_info
            ;;
        3)
            show_user_info
            ;;
        4)
            show_uptime
            ;;
        5)
            show_main_menu
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            system_info
            ;;
    esac
}

# 显示系统版本信息
show_system_version() {
    show_title
    echo "${BLUE}系统版本信息${NC}"
    echo "${GREEN}=======================================${NC}"
    uname -a
    echo
    if [ -f "/etc/os-release" ]; then
        cat /etc/os-release
    fi
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}按Enter键返回...${NC}"
    system_info
}

# 显示硬件信息
show_hardware_info() {
    show_title
    echo "${BLUE}硬件信息${NC}"
    echo "${GREEN}=======================================${NC}"
    
    if command -v lshw &> /dev/null; then
        lshw -short | head -20
    elif command -v lscpu &> /dev/null; then
        lscpu
    else
        echo "硬件信息命令未安装"
    fi
    
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}按Enter键返回...${NC}"
    system_info
}

# 显示当前用户信息
show_user_info() {
    show_title
    echo "${BLUE}当前用户信息${NC}"
    echo "${GREEN}=======================================${NC}"
    whoami
    echo
    id
    echo
    who
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}按Enter键返回...${NC}"
    system_info
}

# 显示开机时间
show_uptime() {
    show_title
    echo "${BLUE}开机时间${NC}"
    echo "${GREEN}=======================================${NC}"
    
    if command -v uptime &> /dev/null; then
        uptime -s
    else
        who -b
    fi
    echo
    uptime
    
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}按Enter键返回...${NC}"
    system_info
}

# 常用工具菜单
common_tools() {
    show_title
    echo "${BLUE}常用工具${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}清屏${NC}"
    echo "${BLUE}2. ${WHITE}查看当前目录${NC}"
    echo "${BLUE}3. ${WHITE}查看命令历史${NC}"
    echo "${BLUE}4. ${WHITE}设置时间${NC}"
    echo "${BLUE}5. ${WHITE}查看日历${NC}"
    echo "${BLUE}6. ${WHITE}返回主菜单${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-6): ${NC}" choice
    
    case $choice in
        1)
            clear_screen
            echo "${GREEN}屏幕已清空${NC}"
            sleep 2
            common_tools
            ;;
        2)
            show_title
            echo "${BLUE}当前目录${NC}"
            echo "${GREEN}=======================================${NC}"
            pwd
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}按Enter键返回...${NC}"
            common_tools
            ;;
        3)
            show_title
            echo "${BLUE}命令历史${NC}"
            echo "${GREEN}=======================================${NC}"
            history | tail -20
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}按Enter键返回...${NC}"
            common_tools
            ;;
        4)
            show_title
            echo "${BLUE}当前时间${NC}"
            echo "${GREEN}=======================================${NC}"
            date
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}按Enter键返回...${NC}"
            common_tools
            ;;
        5)
            show_title
            echo "${BLUE}日历${NC}"
            echo "${GREEN}=======================================${NC}"
            cal
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}按Enter键返回...${NC}"
            common_tools
            ;;
        6)
            show_main_menu
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            common_tools
            ;;
    esac
}

# 帮助指南菜单
help_guide() {
    show_title
    echo "${BLUE}帮助指南${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}基础命令介绍${NC}"
    echo "${BLUE}2. ${WHITE}文件管理指南${NC}"
    echo "${BLUE}3. ${WHITE}系统管理指南${NC}"
    echo "${BLUE}4. ${WHITE}网络命令指南${NC}"
    echo "${BLUE}5. ${WHITE}常见问题解答${NC}"
    echo "${BLUE}6. ${WHITE}返回主菜单${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-6): ${NC}" choice
    
    case $choice in
        1)
            basic_commands
            ;;
        2)
            file_management_guide
            ;;
        3)
            system_management_guide
            ;;
        4)
            network_commands_guide
            ;;
        5)
            faq
            ;;
        6)
            show_main_menu
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            help_guide
            ;;
    esac
}

# 基础命令介绍
basic_commands() {
    show_title
    echo "${BLUE}基础命令介绍${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${WHITE}ls${NC} - 列出文件和目录"
    echo "${WHITE}cd${NC} - 切换目录"
    echo "${WHITE}pwd${NC} - 显示当前目录"
    echo "${WHITE}mkdir${NC} - 创建目录"
    echo "${WHITE}touch${NC} - 创建空文件"
    echo "${WHITE}cat${NC} - 查看文件内容"
    echo "${WHITE}echo${NC} - 输出文本"
    echo "${WHITE}man${NC} - 查看命令手册"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}按Enter键返回...${NC}"
    help_guide
}

# 文件管理指南
file_management_guide() {
    show_title
    echo "${BLUE}文件管理指南${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${WHITE}cp${NC} - 复制文件和目录"
    echo "${WHITE}mv${NC} - 移动/重命名文件和目录"
    echo "${WHITE}rm${NC} - 删除文件和目录"
    echo "${WHITE}find${NC} - 查找文件和目录"
    echo "${WHITE}grep${NC} - 在文件中搜索文本"
    echo "${WHITE}tar${NC} - 打包和压缩文件"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}按Enter键返回...${NC}"
    help_guide
}

# 系统管理指南
system_management_guide() {
    show_title
    echo "${BLUE}系统管理指南${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${WHITE}ps${NC} - 查看进程状态"
    echo "${WHITE}top${NC} - 实时查看系统资源"
    echo "${WHITE}kill${NC} - 终止进程"
    echo "${WHITE}df${NC} - 查看磁盘使用情况"
    echo "${WHITE}free${NC} - 查看内存使用情况"
    echo "${WHITE}uname${NC} - 查看系统信息"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}按Enter键返回...${NC}"
    help_guide
}

# 网络命令指南
network_commands_guide() {
    show_title
    echo "${BLUE}网络命令指南${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${WHITE}ping${NC} - 测试网络连接"
    echo "${WHITE}ifconfig${NC} - 查看网络接口信息"
    echo "${WHITE}curl${NC} - 网络请求工具"
    echo "${WHITE}wget${NC} - 下载文件"
    echo "${WHITE}ssh${NC} - 远程登录"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}按Enter键返回...${NC}"
    help_guide
}

# 常见问题解答
faq() {
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
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}按Enter键返回...${NC}"
    help_guide
}

# 启动助手
show_main_menu