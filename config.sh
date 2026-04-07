#!/bin/bash

# 配置文件 - 管理颜色主题和用户偏好设置

# 默认颜色主题
default_theme() {
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[0;33m'
    BLUE='\033[0;34m'
    PURPLE='\033[0;35m'
    CYAN='\033[0;36m'
    WHITE='\033[0;37m'
    NC='\033[0m' # No Color
}

# 亮色主题
light_theme() {
    RED='\033[1;31m'
    GREEN='\033[1;32m'
    YELLOW='\033[1;33m'
    BLUE='\033[1;34m'
    PURPLE='\033[1;35m'
    CYAN='\033[1;36m'
    WHITE='\033[1;37m'
    NC='\033[0m' # No Color
}

# 暗色主题
dark_theme() {
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[0;33m'
    BLUE='\033[0;34m'
    PURPLE='\033[0;35m'
    CYAN='\033[0;36m'
    WHITE='\033[0;37m'
    NC='\033[0m' # No Color
}

# 蓝色主题
blue_theme() {
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[0;33m'
    BLUE='\033[1;34m'
    PURPLE='\033[0;35m'
    CYAN='\033[0;36m'
    WHITE='\033[0;37m'
    NC='\033[0m' # No Color
}

# 绿色主题
green_theme() {
    RED='\033[0;31m'
    GREEN='\033[1;32m'
    YELLOW='\033[0;33m'
    BLUE='\033[0;34m'
    PURPLE='\033[0;35m'
    CYAN='\033[0;36m'
    WHITE='\033[0;37m'
    NC='\033[0m' # No Color
}

# 加载用户配置
load_config() {
    if [ -f "~/.linux助手/config.sh" ]; then
        source "~/.linux助手/config.sh"
    else
        # 使用默认主题
        default_theme
    fi
}

# 保存用户配置
save_config() {
    mkdir -p "~/.linux助手"
    echo "# 用户配置文件" > "~/.linux助手/config.sh"
    echo "# 颜色主题: $1" >> "~/.linux助手/config.sh"
    echo "$1_theme" >> "~/.linux助手/config.sh"
}

# 显示颜色主题选择
show_theme_selection() {
    echo "${GREEN}=======================================${NC}"
    echo "${YELLOW}        颜色主题选择${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}默认主题${NC}"
    echo "${BLUE}2. ${WHITE}亮色主题${NC}"
    echo "${BLUE}3. ${WHITE}暗色主题${NC}"
    echo "${BLUE}4. ${WHITE}蓝色主题${NC}"
    echo "${BLUE}5. ${WHITE}绿色主题${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择主题 (1-5): ${NC}" choice
    
    case $choice in
        1)
            default_theme
            save_config "default"
            ;;
        2)
            light_theme
            save_config "light"
            ;;
        3)
            dark_theme
            save_config "dark"
            ;;
        4)
            blue_theme
            save_config "blue"
            ;;
        5)
            green_theme
            save_config "green"
            ;;
        *)
            default_theme
            save_config "default"
            ;;
    esac
}

# 显示用户配置菜单
show_config_menu() {
    echo "${GREEN}=======================================${NC}"
    echo "${YELLOW}        用户配置${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}选择颜色主题${NC}"
    echo "${BLUE}2. ${WHITE}恢复默认配置${NC}"
    echo "${BLUE}3. ${WHITE}返回主菜单${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-3): ${NC}" choice
    
    case $choice in
        1)
            show_theme_selection
            ;;
        2)
            default_theme
            save_config "default"
            echo "${GREEN}已恢复默认配置！${NC}"
            sleep 2
            ;;
        3)
            return
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            show_config_menu
            ;;
    esac
}

# 加载默认配置
load_config