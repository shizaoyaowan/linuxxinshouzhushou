#!/bin/bash

# 自动配置和依赖管理脚本

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
    echo "${YELLOW}        Linux命令行工具包配置${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}自动检测和安装依赖${NC}"
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

# 检测并安装依赖
detect_and_install_dependencies() {
    local package_manager=$(detect_package_manager)
    
    show_title
    echo "${BLUE}检测到包管理器: ${WHITE}$package_manager${NC}"
    echo "${GREEN}=======================================${NC}"
    
    # 定义需要的依赖
    local dependencies=()
    
    # 基础依赖
    dependencies+=("coreutils")
    
    # 系统监测依赖
    dependencies+=("procps")
    dependencies+=("sysstat")
    
    # 网络工具依赖
    dependencies+=("net-tools")
    dependencies+=("iproute2")
    dependencies+=("curl")
    dependencies+=("wget")
    
    # 其他依赖
    dependencies+=("bash-completion")
    
    # 检查并安装依赖
    echo "${YELLOW}检查依赖...${NC}"
    
    for dep in "${dependencies[@]}"; do
        echo -n "${BLUE}检查 $dep: ${NC}"
        
        case $package_manager in
            "apt")
                if dpkg -l | grep -q "^ii  $dep "; then
                    echo "${GREEN}已安装${NC}"
                else
                    echo "${YELLOW}未安装，正在安装...${NC}"
                    sudo apt update && sudo apt install -y "$dep"
                    if [ $? -eq 0 ]; then
                        echo "${GREEN}安装成功${NC}"
                    else
                        echo "${RED}安装失败${NC}"
                    fi
                fi
                ;;
            "yum")
                if yum list installed | grep -q "^$dep\."; then
                    echo "${GREEN}已安装${NC}"
                else
                    echo "${YELLOW}未安装，正在安装...${NC}"
                    sudo yum install -y "$dep"
                    if [ $? -eq 0 ]; then
                        echo "${GREEN}安装成功${NC}"
                    else
                        echo "${RED}安装失败${NC}"
                    fi
                fi
                ;;
            "dnf")
                if dnf list installed | grep -q "^$dep\."; then
                    echo "${GREEN}已安装${NC}"
                else
                    echo "${YELLOW}未安装，正在安装...${NC}"
                    sudo dnf install -y "$dep"
                    if [ $? -eq 0 ]; then
                        echo "${GREEN}安装成功${NC}"
                    else
                        echo "${RED}安装失败${NC}"
                    fi
                fi
                ;;
            "pacman")
                if pacman -Q "$dep" &> /dev/null; then
                    echo "${GREEN}已安装${NC}"
                else
                    echo "${YELLOW}未安装，正在安装...${NC}"
                    sudo pacman -S --noconfirm "$dep"
                    if [ $? -eq 0 ]; then
                        echo "${GREEN}安装成功${NC}"
                    else
                        echo "${RED}安装失败${NC}"
                    fi
                fi
                ;;
            "zypper")
                if zypper se -i "$dep" | grep -q "i | $dep"; then
                    echo "${GREEN}已安装${NC}"
                else
                    echo "${YELLOW}未安装，正在安装...${NC}"
                    sudo zypper install -y "$dep"
                    if [ $? -eq 0 ]; then
                        echo "${GREEN}安装成功${NC}"
                    else
                        echo "${RED}安装失败${NC}"
                    fi
                fi
                ;;
            *)
                echo "${YELLOW}无法自动安装依赖，请手动安装${NC}"
                ;;
        esac
    done
    
    echo "${GREEN}=======================================${NC}"
}

# 检测并安装网络速度测试工具
detect_and_install_speedtest() {
    show_title
    echo "${BLUE}检测网络速度测试工具...${NC}"
    
    if command -v speedtest-cli &> /dev/null; then
        echo "${GREEN}speedtest-cli 已安装${NC}"
    else
        echo "${YELLOW}speedtest-cli 未安装，正在安装...${NC}"
        
        if command -v pip &> /dev/null; then
            pip install speedtest-cli
        elif command -v pip3 &> /dev/null; then
            pip3 install speedtest-cli
        else
            echo "${YELLOW}pip 未安装，尝试使用包管理器安装...${NC}"
            
            local package_manager=$(detect_package_manager)
            case $package_manager in
                "apt")
                    sudo apt install -y speedtest-cli
                    ;;
                "yum")
                    sudo yum install -y speedtest-cli
                    ;;
                "dnf")
                    sudo dnf install -y speedtest-cli
                    ;;
                "pacman")
                    sudo pacman -S --noconfirm speedtest-cli
                    ;;
                "zypper")
                    sudo zypper install -y speedtest-cli
                    ;;
                *)
                    echo "${RED}无法自动安装 speedtest-cli，请手动安装${NC}"
                    ;;
            esac
        fi
        
        if [ $? -eq 0 ]; then
            echo "${GREEN}安装成功${NC}"
        else
            echo "${YELLOW}安装失败，将使用curl作为替代方案${NC}"
        fi
    fi
    
    echo "${GREEN}=======================================${NC}"
}

# 配置系统优化
configure_system_optimizations() {
    show_title
    echo "${BLUE}配置系统优化...${NC}"
    
    # 创建配置目录
    mkdir -p "~/.linux助手"
    
    # 复制配置文件
    if [ -f "config.sh" ]; then
        cp "config.sh" "~/.linux助手/"
        echo "${GREEN}配置文件已复制${NC}"
    fi
    
    # 配置.bashrc
    if [ -f "~/.bashrc" ]; then
        # 检查是否已添加配置
        if ! grep -q "linuxminglinghang" "~/.bashrc"; then
            echo "${YELLOW}更新 .bashrc 文件...${NC}"
            cat ".bashrc" >> "~/.bashrc"
            echo "${GREEN}.bashrc 文件已更新${NC}"
        else
            echo "${GREEN}.bashrc 配置已存在${NC}"
        fi
    else
        echo "${YELLOW}~/.bashrc 文件不存在，创建新文件...${NC}"
        cp ".bashrc" "~/.bashrc"
        echo "${GREEN}.bashrc 文件已创建${NC}"
    fi
    
    # 设置脚本执行权限
    chmod +x "helpme.sh" "sysmonitor.sh" "filemanager.sh" "linux新手开荒助手.sh" "setup.sh" "lang_system.sh"
    echo "${GREEN}脚本执行权限已设置${NC}"
    
    echo "${GREEN}=======================================${NC}"
}

# 显示系统信息
display_system_info() {
    show_title
    echo "${BLUE}系统信息${NC}"
    echo "${GREEN}=======================================${NC}"
    
    # 操作系统信息
    if [ -f "/etc/os-release" ]; then
        echo "${BLUE}操作系统:${NC}"
        cat "/etc/os-release" | grep -E "NAME|VERSION" | head -2
    else
        echo "${BLUE}操作系统:${NC}"
        uname -a
    fi
    
    # 内核版本
    echo "${BLUE}内核版本:${NC}"
    uname -r
    
    # Bash版本
    echo "${BLUE}Bash版本:${NC}"
    bash --version | head -1
    
    # 已安装的依赖
    echo "${BLUE}已安装的关键依赖:${NC}"
    for cmd in ls cd cp mv rm ps top df free ping curl wget; do
        if command -v $cmd &> /dev/null; then
            echo "${GREEN}$cmd: 已安装${NC}"
        else
            echo "${RED}$cmd: 未安装${NC}"
        fi
    done
    
    echo "${GREEN}=======================================${NC}"
}

# 主菜单
show_main_menu() {
    show_title
    echo "${BLUE}1. ${WHITE}自动检测和安装依赖${NC}"
    echo "${BLUE}2. ${WHITE}安装网络速度测试工具${NC}"
    echo "${BLUE}3. ${WHITE}配置系统优化${NC}"
    echo "${BLUE}4. ${WHITE}显示系统信息${NC}"
    echo "${BLUE}5. ${WHITE}全部自动配置${NC}"
    echo "${BLUE}6. ${WHITE}退出${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-6): ${NC}" choice
    
    case $choice in
        1)
            detect_and_install_dependencies
            read -p "${YELLOW}按Enter键返回...${NC}"
            show_main_menu
            ;;
        2)
            detect_and_install_speedtest
            read -p "${YELLOW}按Enter键返回...${NC}"
            show_main_menu
            ;;
        3)
            configure_system_optimizations
            read -p "${YELLOW}按Enter键返回...${NC}"
            show_main_menu
            ;;
        4)
            display_system_info
            read -p "${YELLOW}按Enter键返回...${NC}"
            show_main_menu
            ;;
        5)
            show_title
            echo "${YELLOW}正在执行全部自动配置...${NC}"
            echo "${GREEN}=======================================${NC}"
            
            # 执行所有配置步骤
            detect_and_install_dependencies
            progress_bar 2
            
            detect_and_install_speedtest
            progress_bar 2
            
            configure_system_optimizations
            progress_bar 2
            
            display_system_info
            
            echo "${GREEN}=======================================${NC}"
            echo "${GREEN}全部自动配置完成！${NC}"
            echo "${YELLOW}请重启终端或执行 'source ~/.bashrc' 使配置生效${NC}"
            read -p "${YELLOW}按Enter键返回...${NC}"
            show_main_menu
            ;;
        6)
            echo "${GREEN}退出配置工具${NC}"
            exit 0
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            show_main_menu
            ;;
    esac
}

# 启动配置工具
show_main_menu