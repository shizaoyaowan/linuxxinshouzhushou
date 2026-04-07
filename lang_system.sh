#!/bin/bash

# 语言系统 - 支持中英双语

# 默认语言
CURRENT_LANG="zh"

# 中文文本
TEXT_ZH() {
    case $1 in
        "title") echo "Linux新手开荒助手" ;;
        "subtitle") echo "专为新手设计，无需记住命令" ;;
        "menu_hint") echo "提示: 可以使用键盘数字键选择操作" ;;
        "choose_option") echo "请选择操作" ;;
        "press_enter") echo "按Enter键返回..." ;;
        "file_management") echo "文件管理" ;;
        "system_monitor") echo "系统监测" ;;
        "network_tools") echo "网络工具" ;;
        "system_info") echo "系统信息" ;;
        "common_tools") echo "常用工具" ;;
        "help_guide") echo "帮助指南" ;;
        "user_config") echo "用户配置" ;;
        "newuser_helper") echo "新用户助手" ;;
        "advanced_tools") echo "高级功能模块" ;;
        "performance_optimize") echo "性能优化" ;;
        "learning_report") echo "学习报告" ;;
        "exit") echo "退出" ;;
        "thanks") echo "感谢使用Linux新手开荒助手！" ;;
        "invalid_option") echo "无效选择，请重新输入！" ;;
        "language_select") echo "语言选择" ;;
        "chinese") echo "中文" ;;
        "english") echo "English" ;;
        "language_set") echo "语言已设置" ;;
        *) echo "" ;;
    esac
}

# 英文文本
TEXT_EN() {
    case $1 in
        "title") echo "Linux Newbie Helper" ;;
        "subtitle") echo "Designed for newbies, no need to remember commands" ;;
        "menu_hint") echo "Hint: Use number keys to select options" ;;
        "choose_option") echo "Please choose an option" ;;
        "press_enter") echo "Press Enter to return..." ;;
        "file_management") echo "File Management" ;;
        "system_monitor") echo "System Monitor" ;;
        "network_tools") echo "Network Tools" ;;
        "system_info") echo "System Info" ;;
        "common_tools") echo "Common Tools" ;;
        "help_guide") echo "Help Guide" ;;
        "user_config") echo "User Config" ;;
        "newuser_helper") echo "New User Helper" ;;
        "advanced_tools") echo "Advanced Tools" ;;
        "performance_optimize") echo "Performance Optimize" ;;
        "learning_report") echo "Learning Report" ;;
        "exit") echo "Exit" ;;
        "thanks") echo "Thank you for using Linux Newbie Helper!" ;;
        "invalid_option") echo "Invalid option, please try again!" ;;
        "language_select") echo "Language Selection" ;;
        "chinese") echo "中文" ;;
        "english") echo "English" ;;
        "language_set") echo "Language set" ;;
        *) echo "" ;;
    esac
}

# 获取文本
TEXT() {
    if [ "$CURRENT_LANG" = "zh" ]; then
        TEXT_ZH "$1"
    else
        TEXT_EN "$1"
    esac
}

# 加载语言配置
load_lang_config() {
    if [ -f "~/.linux助手/lang.conf" ]; then
        source "~/.linux助手/lang.conf"
    else
        mkdir -p "~/.linux助手"
        save_lang_config
    fi
}

# 保存语言配置
save_lang_config() {
    mkdir -p "~/.linux助手"
    echo "CURRENT_LANG=\"$CURRENT_LANG\"" > "~/.linux助手/lang.conf"
}

# 语言选择菜单
show_language_menu() {
    clear
    echo "${GREEN}=======================================${NC}"
    echo "${YELLOW}        $(TEXT "language_select")${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}$(TEXT "chinese")${NC}"
    echo "${BLUE}2. ${WHITE}$(TEXT "english")${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}$(TEXT "choose_option") (1-2): ${NC}" choice
    
    case $choice in
        1)
            CURRENT_LANG="zh"
            save_lang_config
            echo "${GREEN}$(TEXT "language_set")!${NC}"
            sleep 1
            ;;
        2)
            CURRENT_LANG="en"
            save_lang_config
            echo "${GREEN}$(TEXT "language_set")!${NC}"
            sleep 1
            ;;
        *)
            echo "${RED}$(TEXT "invalid_option")${NC}"
            sleep 2
            show_language_menu
            ;;
    esac
}

# 初始化语言系统
init_lang_system() {
    load_lang_config
}

# 导出函数和变量供其他脚本使用
export -f TEXT
export -f TEXT_ZH
export -f TEXT_EN
export -f load_lang_config
export -f save_lang_config
export -f show_language_menu
export -f init_lang_system
export CURRENT_LANG