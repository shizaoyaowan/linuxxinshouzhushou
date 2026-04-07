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

# 当前目录
current_dir="."

# 显示文件列表
show_files() {
    clear
    echo "${GREEN}=======================================${NC}"
    echo "${YELLOW}        文件管理器${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}当前目录: ${WHITE}$(pwd)${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}0. ${WHITE}返回上一级目录${NC}"
    echo "${BLUE}1. ${WHITE}新建目录${NC}"
    echo "${BLUE}2. ${WHITE}新建文件${NC}"
    echo "${BLUE}3. ${WHITE}复制文件/目录${NC}"
    echo "${BLUE}4. ${WHITE}移动文件/目录${NC}"
    echo "${BLUE}5. ${WHITE}删除文件/目录${NC}"
    echo "${BLUE}6. ${WHITE}查看文件内容${NC}"
    echo "${BLUE}7. ${WHITE}搜索文件${NC}"
    echo "${BLUE}8. ${WHITE}退出${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}文件列表:${NC}"
    echo "${GREEN}=======================================${NC}"
    
    # 列出文件和目录，使用不同颜色区分
    local i=9
    for item in *; do
        if [ -d "$item" ]; then
            echo "${BLUE}$i. ${CYAN}[目录] ${WHITE}$item${NC}"
        else
            echo "${BLUE}$i. ${WHITE}$item${NC}"
        fi
        i=$((i+1))
    done
    
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (0-8 或文件编号): ${NC}" choice
    
    return $choice
}

# 主循环
while true; do
    cd "$current_dir"
    show_files
    choice=$?
    
    case $choice in
        0)
            # 返回上一级目录
            cd ..
            current_dir="."
            ;;
        1)
            # 新建目录
            read -p "${YELLOW}请输入目录名称: ${NC}" dir_name
            mkdir -p "$dir_name"
            echo "${GREEN}目录创建成功！${NC}"
            sleep 1
            ;;
        2)
            # 新建文件
            read -p "${YELLOW}请输入文件名称: ${NC}" file_name
            touch "$file_name"
            echo "${GREEN}文件创建成功！${NC}"
            sleep 1
            ;;
        3)
            # 复制文件/目录
            read -p "${YELLOW}请输入要复制的文件/目录: ${NC}" source
            read -p "${YELLOW}请输入目标位置: ${NC}" destination
            cp -r "$source" "$destination"
            echo "${GREEN}复制成功！${NC}"
            sleep 1
            ;;
        4)
            # 移动文件/目录
            read -p "${YELLOW}请输入要移动的文件/目录: ${NC}" source
            read -p "${YELLOW}请输入目标位置: ${NC}" destination
            mv "$source" "$destination"
            echo "${GREEN}移动成功！${NC}"
            sleep 1
            ;;
        5)
            # 删除文件/目录
            read -p "${YELLOW}请输入要删除的文件/目录: ${NC}" target
            read -p "${RED}确定要删除 $target 吗？(y/n): ${NC}" confirm
            if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
                rm -rf "$target"
                echo "${GREEN}删除成功！${NC}"
            else
                echo "${YELLOW}取消删除${NC}"
            fi
            sleep 1
            ;;
        6)
            # 查看文件内容
            read -p "${YELLOW}请输入要查看的文件: ${NC}" file
            if [ -f "$file" ]; then
                echo "${GREEN}=======================================${NC}"
                echo "${YELLOW}文件内容: $file${NC}"
                echo "${GREEN}=======================================${NC}"
                cat "$file"
                echo "${GREEN}=======================================${NC}"
                read -p "${YELLOW}按Enter键返回...${NC}"
            else
                echo "${RED}文件不存在！${NC}"
                sleep 1
            fi
            ;;
        7)
            # 搜索文件
            read -p "${YELLOW}请输入搜索关键词: ${NC}" keyword
            echo "${GREEN}=======================================${NC}"
            echo "${YELLOW}搜索结果:${NC}"
            echo "${GREEN}=======================================${NC}"
            find . -name "*$keyword*" | head -20
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}按Enter键返回...${NC}"
            ;;
        8)
            # 退出
            echo "${GREEN}感谢使用文件管理器！${NC}"
            exit 0
            ;;
        *)
            # 进入目录或查看文件
            if [ $choice -ge 9 ]; then
                local i=9
                for item in *; do
                    if [ $i -eq $choice ]; then
                        if [ -d "$item" ]; then
                            current_dir="$item"
                        else
                            echo "${GREEN}=======================================${NC}"
                            echo "${YELLOW}文件内容: $item${NC}"
                            echo "${GREEN}=======================================${NC}"
                            cat "$item"
                            echo "${GREEN}=======================================${NC}"
                            read -p "${YELLOW}按Enter键返回...${NC}"
                        fi
                        break
                    fi
                    i=$((i+1))
                done
            else
                echo "${RED}无效选择，请重新输入！${NC}"
                sleep 1
            fi
            ;;
    esac
done