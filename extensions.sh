#!/bin/bash

# 扩展功能模块

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
    echo "${YELLOW}        Linux扩展功能模块${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}高级系统管理和开发工具集${NC}"
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

# 1. 多媒体工具模块
multimedia_tools() {
    show_title
    echo "${BLUE}多媒体工具模块${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}音频转换和编辑${NC}"
    echo "${BLUE}2. ${WHITE}视频格式转换${NC}"
    echo "${BLUE}3. ${WHITE}图像编辑和调整${NC}"
    echo "${BLUE}4. ${WHITE}多媒体文件信息查看${NC}"
    echo "${BLUE}5. ${WHITE}批量多媒体文件处理${NC}"
    echo "${BLUE}6. ${WHITE}返回上一级${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-6): ${NC}" choice
    
    case $choice in
        1)
            show_title
            echo "${BLUE}音频转换和编辑${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请输入音频文件路径: ${NC}" audio_file
            read -p "${YELLOW}请输入目标格式 (如: mp3, wav, ogg): ${NC}" format
            
            if [ -f "$audio_file" ]; then
                echo "${YELLOW}正在转换音频文件...${NC}"
                if command -v ffmpeg &> /dev/null; then
                    output_file="${audio_file%.*}.$format"
                    ffmpeg -i "$audio_file" "$output_file" 2>/dev/null
                    if [ $? -eq 0 ]; then
                        echo "${GREEN}音频转换成功！${NC}"
                        echo "${YELLOW}输出文件: ${WHITE}$output_file${NC}"
                    else
                        echo "${RED}音频转换失败！${NC}"
                    fi
                else
                    echo "${RED}ffmpeg未安装，请先安装ffmpeg${NC}"
                fi
            else
                echo "${RED}音频文件不存在！${NC}"
            fi
            read -p "${YELLOW}按Enter键返回...${NC}"
            multimedia_tools
            ;;
        2)
            show_title
            echo "${BLUE}视频格式转换${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请输入视频文件路径: ${NC}" video_file
            read -p "${YELLOW}请输入目标格式 (如: mp4, avi, mkv): ${NC}" format
            
            if [ -f "$video_file" ]; then
                echo "${YELLOW}正在转换视频文件...${NC}"
                if command -v ffmpeg &> /dev/null; then
                    output_file="${video_file%.*}.$format"
                    ffmpeg -i "$video_file" "$output_file" 2>/dev/null
                    if [ $? -eq 0 ]; then
                        echo "${GREEN}视频转换成功！${NC}"
                        echo "${YELLOW}输出文件: ${WHITE}$output_file${NC}"
                    else
                        echo "${RED}视频转换失败！${NC}"
                    fi
                else
                    echo "${RED}ffmpeg未安装，请先安装ffmpeg${NC}"
                fi
            else
                echo "${RED}视频文件不存在！${NC}"
            fi
            read -p "${YELLOW}按Enter键返回...${NC}"
            multimedia_tools
            ;;
        3)
            show_title
            echo "${BLUE}图像编辑和调整${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请输入图像文件路径: ${NC}" image_file
            read -p "${YELLOW}请选择操作 (1. 调整大小 2. 旋转 3. 裁剪): ${NC}" op
            
            if [ -f "$image_file" ]; then
                echo "${YELLOW}正在处理图像...${NC}"
                if command -v convert &> /dev/null; then
                    case $op in
                        1)
                            read -p "${YELLOW}请输入新宽度: ${NC}" width
                            read -p "${YELLOW}请输入新高度: ${NC}" height
                            output_file="${image_file%.*}_resized.${image_file##*.}"
                            convert "$image_file" -resize "${width}x${height}" "$output_file"
                            ;;
                        2)
                            read -p "${YELLOW}请输入旋转角度: ${NC}" angle
                            output_file="${image_file%.*}_rotated.${image_file##*.}"
                            convert "$image_file" -rotate "$angle" "$output_file"
                            ;;
                        3)
                            read -p "${YELLOW}请输入裁剪区域 (x,y,width,height): ${NC}" crop
                            output_file="${image_file%.*}_cropped.${image_file##*.}"
                            convert "$image_file" -crop "$crop" "$output_file"
                            ;;
                        *)
                            echo "${RED}无效操作！${NC}"
                            read -p "${YELLOW}按Enter键返回...${NC}"
                            multimedia_tools
                            return
                            ;;
                    esac
                    if [ $? -eq 0 ]; then
                        echo "${GREEN}图像处理成功！${NC}"
                        echo "${YELLOW}输出文件: ${WHITE}$output_file${NC}"
                    else
                        echo "${RED}图像处理失败！${NC}"
                    fi
                else
                    echo "${RED}ImageMagick未安装，请先安装ImageMagick${NC}"
                fi
            else
                echo "${RED}图像文件不存在！${NC}"
            fi
            read -p "${YELLOW}按Enter键返回...${NC}"
            multimedia_tools
            ;;
        4)
            show_title
            echo "${BLUE}多媒体文件信息查看${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请输入多媒体文件路径: ${NC}" media_file
            
            if [ -f "$media_file" ]; then
                echo "${YELLOW}文件信息:${NC}"
                if command -v file &> /dev/null; then
                    file "$media_file"
                fi
                if command -v mediainfo &> /dev/null; then
                    mediainfo "$media_file"
                elif command -v ffmpeg &> /dev/null; then
                    ffmpeg -i "$media_file" 2>&1 | head -20
                fi
            else
                echo "${RED}文件不存在！${NC}"
            fi
            read -p "${YELLOW}按Enter键返回...${NC}"
            multimedia_tools
            ;;
        5)
            show_title
            echo "${BLUE}批量多媒体文件处理${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请输入文件匹配模式 (如: *.jpg, *.mp3): ${NC}" pattern
            read -p "${YELLOW}请选择操作 (1. 转换格式 2. 重命名 3. 调整大小): ${NC}" op
            
            echo "${YELLOW}正在处理文件...${NC}"
            case $op in
                1)
                    read -p "${YELLOW}请输入目标格式: ${NC}" format
                    for file in $pattern; do
                        if [ -f "$file" ]; then
                            output_file="${file%.*}.$format"
                            if command -v ffmpeg &> /dev/null; then
                                ffmpeg -i "$file" "$output_file" 2>/dev/null
                                echo "${WHITE}$file${NC} → ${GREEN}$output_file${NC}"
                            fi
                        fi
                    done
                    ;;
                2)
                    read -p "${YELLOW}请输入新文件名模式 (如: file_##): ${NC}" new_pattern
                    i=1
                    for file in $pattern; do
                        if [ -f "$file" ]; then
                            ext="${file##*.}"
                            new_name="$(echo "$new_pattern" | sed "s/##/$i/")".$ext
                            mv "$file" "$new_name"
                            echo "${WHITE}$file${NC} → ${GREEN}$new_name${NC}"
                            i=$((i+1))
                        fi
                    done
                    ;;
                3)
                    read -p "${YELLOW}请输入新宽度: ${NC}" width
                    read -p "${YELLOW}请输入新高度: ${NC}" height
                    for file in $pattern; do
                        if [ -f "$file" ]; then
                            output_file="${file%.*}_resized.${file##*.}"
                            if command -v convert &> /dev/null; then
                                convert "$file" -resize "${width}x${height}" "$output_file"
                                echo "${WHITE}$file${NC} → ${GREEN}$output_file${NC}"
                            fi
                        fi
                    done
                    ;;
                *)
                    echo "${RED}无效操作！${NC}"
                    ;;
            esac
            echo "${GREEN}批量处理完成！${NC}"
            read -p "${YELLOW}按Enter键返回...${NC}"
            multimedia_tools
            ;;
        6)
            return
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            multimedia_tools
            ;;
    esac
}

# 2. 开发工具模块
development_tools() {
    show_title
    echo "${BLUE}开发工具模块${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}代码编辑器${NC}"
    echo "${BLUE}2. ${WHITE}项目构建工具${NC}"
    echo "${BLUE}3. ${WHITE}版本控制 (Git)${NC}"
    echo "${BLUE}4. ${WHITE}开发环境配置${NC}"
    echo "${BLUE}5. ${WHITE}依赖管理${NC}"
    echo "${BLUE}6. ${WHITE}返回上一级${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-6): ${NC}" choice
    
    case $choice in
        1)
            show_title
            echo "${BLUE}代码编辑器${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${BLUE}1. ${WHITE}nano${NC}"
            echo "${BLUE}2. ${WHITE}vim${NC}"
            echo "${BLUE}3. ${WHITE}返回上一级${NC}"
            read -p "${YELLOW}请选择编辑器 (1-3): ${NC}" editor_choice
            
            case $editor_choice in
                1)
                    read -p "${YELLOW}请输入文件路径: ${NC}" file_path
                    nano "$file_path"
                    ;;
                2)
                    read -p "${YELLOW}请输入文件路径: ${NC}" file_path
                    vim "$file_path"
                    ;;
                3)
                    development_tools
                    return
                    ;;
                *)
                    echo "${RED}无效选择！${NC}"
                    sleep 2
                    development_tools
                    ;;
            esac
            read -p "${YELLOW}按Enter键返回...${NC}"
            development_tools
            ;;
        2)
            show_title
            echo "${BLUE}项目构建工具${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${BLUE}1. ${WHITE}make${NC}"
            echo "${BLUE}2. ${WHITE}cmake${NC}"
            echo "${BLUE}3. ${WHITE}返回上一级${NC}"
            read -p "${YELLOW}请选择构建工具 (1-3): ${NC}" build_choice
            
            case $build_choice in
                1)
                    read -p "${YELLOW}请输入项目目录: ${NC}" project_dir
                    cd "$project_dir" && make
                    ;;
                2)
                    read -p "${YELLOW}请输入项目目录: ${NC}" project_dir
                    read -p "${YELLOW}请输入构建目录: ${NC}" build_dir
                    mkdir -p "$build_dir"
                    cd "$build_dir" && cmake "$project_dir"
                    ;;
                3)
                    development_tools
                    return
                    ;;
                *)
                    echo "${RED}无效选择！${NC}"
                    sleep 2
                    development_tools
                    ;;
            esac
            read -p "${YELLOW}按Enter键返回...${NC}"
            development_tools
            ;;
        3)
            show_title
            echo "${BLUE}版本控制 (Git)${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${BLUE}1. ${WHITE}初始化仓库${NC}"
            echo "${BLUE}2. ${WHITE}提交更改${NC}"
            echo "${BLUE}3. ${WHITE}查看状态${NC}"
            echo "${BLUE}4. ${WHITE}推送到远程${NC}"
            echo "${BLUE}5. ${WHITE}返回上一级${NC}"
            read -p "${YELLOW}请选择操作 (1-5): ${NC}" git_choice
            
            case $git_choice in
                1)
                    read -p "${YELLOW}请输入仓库目录: ${NC}" repo_dir
                    cd "$repo_dir" && git init
                    ;;
                2)
                    read -p "${YELLOW}请输入仓库目录: ${NC}" repo_dir
                    read -p "${YELLOW}请输入提交信息: ${NC}" commit_msg
                    cd "$repo_dir" && git add . && git commit -m "$commit_msg"
                    ;;
                3)
                    read -p "${YELLOW}请输入仓库目录: ${NC}" repo_dir
                    cd "$repo_dir" && git status
                    ;;
                4)
                    read -p "${YELLOW}请输入仓库目录: ${NC}" repo_dir
                    read -p "${YELLOW}请输入远程仓库URL: ${NC}" remote_url
                    read -p "${YELLOW}请输入分支名称: ${NC}" branch
                    cd "$repo_dir" && git push -u "$remote_url" "$branch"
                    ;;
                5)
                    development_tools
                    return
                    ;;
                *)
                    echo "${RED}无效选择！${NC}"
                    sleep 2
                    development_tools
                    ;;
            esac
            read -p "${YELLOW}按Enter键返回...${NC}"
            development_tools
            ;;
        4)
            show_title
            echo "${BLUE}开发环境配置${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${BLUE}1. ${WHITE}安装开发依赖${NC}"
            echo "${BLUE}2. ${WHITE}配置环境变量${NC}"
            echo "${BLUE}3. ${WHITE}返回上一级${NC}"
            read -p "${YELLOW}请选择操作 (1-3): ${NC}" env_choice
            
            case $env_choice in
                1)
                    echo "${YELLOW}正在安装开发依赖...${NC}"
                    if command -v apt &> /dev/null; then
                        apt install -y build-essential git curl wget
                    elif command -v yum &> /dev/null; then
                        yum groupinstall -y "Development Tools"
                        yum install -y git curl wget
                    fi
                    echo "${GREEN}开发依赖安装完成！${NC}"
                    ;;
                2)
                    read -p "${YELLOW}请输入环境变量名称: ${NC}" var_name
                    read -p "${YELLOW}请输入环境变量值: ${NC}" var_value
                    echo "export $var_name=$var_value" >> ~/.bashrc
                    source ~/.bashrc
                    echo "${GREEN}环境变量配置完成！${NC}"
                    ;;
                3)
                    development_tools
                    return
                    ;;
                *)
                    echo "${RED}无效选择！${NC}"
                    sleep 2
                    development_tools
                    ;;
            esac
            read -p "${YELLOW}按Enter键返回...${NC}"
            development_tools
            ;;
        5)
            show_title
            echo "${BLUE}依赖管理${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${BLUE}1. ${WHITE}npm (Node.js)${NC}"
            echo "${BLUE}2. ${WHITE}pip (Python)${NC}"
            echo "${BLUE}3. ${WHITE}composer (PHP)${NC}"
            echo "${BLUE}4. ${WHITE}返回上一级${NC}"
            read -p "${YELLOW}请选择包管理器 (1-4): ${NC}" pm_choice
            
            case $pm_choice in
                1)
                    read -p "${YELLOW}请输入操作 (install, update, list): ${NC}" npm_op
                    case $npm_op in
                        install)
                            read -p "${YELLOW}请输入包名: ${NC}" package
                            npm install "$package"
                            ;;
                        update)
                            npm update
                            ;;
                        list)
                            npm list
                            ;;
                        *)
                            echo "${RED}无效操作！${NC}"
                            ;;
                    esac
                    ;;
                2)
                    read -p "${YELLOW}请输入操作 (install, update, list): ${NC}" pip_op
                    case $pip_op in
                        install)
                            read -p "${YELLOW}请输入包名: ${NC}" package
                            pip install "$package"
                            ;;
                        update)
                            pip install --upgrade pip
                            ;;
                        list)
                            pip list
                            ;;
                        *)
                            echo "${RED}无效操作！${NC}"
                            ;;
                    esac
                    ;;
                3)
                    read -p "${YELLOW}请输入操作 (install, update, list): ${NC}" composer_op
                    case $composer_op in
                        install)
                            composer install
                            ;;
                        update)
                            composer update
                            ;;
                        list)
                            composer show
                            ;;
                        *)
                            echo "${RED}无效操作！${NC}"
                            ;;
                    esac
                    ;;
                4)
                    development_tools
                    return
                    ;;
                *)
                    echo "${RED}无效选择！${NC}"
                    sleep 2
                    development_tools
                    ;;
            esac
            read -p "${YELLOW}按Enter键返回...${NC}"
            development_tools
            ;;
        6)
            return
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            development_tools
            ;;
    esac
}

# 3. 数据管理模块
data_management() {
    show_title
    echo "${BLUE}数据管理模块${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}数据库连接和管理${NC}"
    echo "${BLUE}2. ${WHITE}数据导入/导出${NC}"
    echo "${BLUE}3. ${WHITE}SQL查询执行${NC}"
    echo "${BLUE}4. ${WHITE}数据备份和恢复${NC}"
    echo "${BLUE}5. ${WHITE}数据库性能优化${NC}"
    echo "${BLUE}6. ${WHITE}返回上一级${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-6): ${NC}" choice
    
    case $choice in
        1)
            show_title
            echo "${BLUE}数据库连接和管理${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${BLUE}1. ${WHITE}MySQL/MariaDB${NC}"
            echo "${BLUE}2. ${WHITE}PostgreSQL${NC}"
            echo "${BLUE}3. ${WHITE}返回上一级${NC}"
            read -p "${YELLOW}请选择数据库类型 (1-3): ${NC}" db_choice
            
            case $db_choice in
                1)
                    read -p "${YELLOW}请输入用户名: ${NC}" user
                    read -s -p "${YELLOW}请输入密码: ${NC}" pass
                    echo
                    read -p "${YELLOW}请输入数据库名称: ${NC}" db
                    echo "${YELLOW}连接到MySQL数据库...${NC}"
                    mysql -u "$user" -p"$pass" "$db"
                    ;;
                2)
                    read -p "${YELLOW}请输入用户名: ${NC}" user
                    read -s -p "${YELLOW}请输入密码: ${NC}" pass
                    echo
                    read -p "${YELLOW}请输入数据库名称: ${NC}" db
                    echo "${YELLOW}连接到PostgreSQL数据库...${NC}"
                    PGPASSWORD="$pass" psql -U "$user" -d "$db"
                    ;;
                3)
                    data_management
                    return
                    ;;
                *)
                    echo "${RED}无效选择！${NC}"
                    sleep 2
                    data_management
                    ;;
            esac
            read -p "${YELLOW}按Enter键返回...${NC}"
            data_management
            ;;
        2)
            show_title
            echo "${BLUE}数据导入/导出${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${BLUE}1. ${WHITE}导出数据${NC}"
            echo "${BLUE}2. ${WHITE}导入数据${NC}"
            echo "${BLUE}3. ${WHITE}返回上一级${NC}"
            read -p "${YELLOW}请选择操作 (1-3): ${NC}" import_export_choice
            
            case $import_export_choice in
                1)
                    read -p "${YELLOW}请输入数据库类型 (mysql/postgresql): ${NC}" db_type
                    read -p "${YELLOW}请输入用户名: ${NC}" user
                    read -s -p "${YELLOW}请输入密码: ${NC}" pass
                    echo
                    read -p "${YELLOW}请输入数据库名称: ${NC}" db
                    read -p "${YELLOW}请输入导出文件路径: ${NC}" export_file
                    
                    echo "${YELLOW}正在导出数据...${NC}"
                    case $db_type in
                        mysql)
                            mysqldump -u "$user" -p"$pass" "$db" > "$export_file"
                            ;;
                        postgresql)
                            PGPASSWORD="$pass" pg_dump -U "$user" "$db" > "$export_file"
                            ;;
                        *)
                            echo "${RED}无效数据库类型！${NC}"
                            ;;
                    esac
                    if [ $? -eq 0 ]; then
                        echo "${GREEN}数据导出成功！${NC}"
                        echo "${YELLOW}导出文件: ${WHITE}$export_file${NC}"
                    else
                        echo "${RED}数据导出失败！${NC}"
                    fi
                    ;;
                2)
                    read -p "${YELLOW}请输入数据库类型 (mysql/postgresql): ${NC}" db_type
                    read -p "${YELLOW}请输入用户名: ${NC}" user
                    read -s -p "${YELLOW}请输入密码: ${NC}" pass
                    echo
                    read -p "${YELLOW}请输入数据库名称: ${NC}" db
                    read -p "${YELLOW}请输入导入文件路径: ${NC}" import_file
                    
                    echo "${YELLOW}正在导入数据...${NC}"
                    case $db_type in
                        mysql)
                            mysql -u "$user" -p"$pass" "$db" < "$import_file"
                            ;;
                        postgresql)
                            PGPASSWORD="$pass" psql -U "$user" -d "$db" < "$import_file"
                            ;;
                        *)
                            echo "${RED}无效数据库类型！${NC}"
                            ;;
                    esac
                    if [ $? -eq 0 ]; then
                        echo "${GREEN}数据导入成功！${NC}"
                    else
                        echo "${RED}数据导入失败！${NC}"
                    fi
                    ;;
                3)
                    data_management
                    return
                    ;;
                *)
                    echo "${RED}无效选择！${NC}"
                    sleep 2
                    data_management
                    ;;
            esac
            read -p "${YELLOW}按Enter键返回...${NC}"
            data_management
            ;;
        3)
            show_title
            echo "${BLUE}SQL查询执行${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请输入数据库类型 (mysql/postgresql): ${NC}" db_type
            read -p "${YELLOW}请输入用户名: ${NC}" user
            read -s -p "${YELLOW}请输入密码: ${NC}" pass
            echo
            read -p "${YELLOW}请输入数据库名称: ${NC}" db
            read -p "${YELLOW}请输入SQL查询: ${NC}" query
            
            echo "${YELLOW}正在执行SQL查询...${NC}"
            case $db_type in
                mysql)
                    mysql -u "$user" -p"$pass" "$db" -e "$query"
                    ;;
                postgresql)
                    PGPASSWORD="$pass" psql -U "$user" -d "$db" -c "$query"
                    ;;
                *)
                    echo "${RED}无效数据库类型！${NC}"
                    ;;
            esac
            read -p "${YELLOW}按Enter键返回...${NC}"
            data_management
            ;;
        4)
            show_title
            echo "${BLUE}数据备份和恢复${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${BLUE}1. ${WHITE}创建备份${NC}"
            echo "${BLUE}2. ${WHITE}恢复备份${NC}"
            echo "${BLUE}3. ${WHITE}返回上一级${NC}"
            read -p "${YELLOW}请选择操作 (1-3): ${NC}" backup_choice
            
            case $backup_choice in
                1)
                    read -p "${YELLOW}请输入数据库类型 (mysql/postgresql): ${NC}" db_type
                    read -p "${YELLOW}请输入用户名: ${NC}" user
                    read -s -p "${YELLOW}请输入密码: ${NC}" pass
                    echo
                    read -p "${YELLOW}请输入数据库名称: ${NC}" db
                    backup_file="${db}_$(date +%Y%m%d_%H%M%S).sql"
                    
                    echo "${YELLOW}正在创建备份...${NC}"
                    case $db_type in
                        mysql)
                            mysqldump -u "$user" -p"$pass" "$db" > "$backup_file"
                            ;;
                        postgresql)
                            PGPASSWORD="$pass" pg_dump -U "$user" "$db" > "$backup_file"
                            ;;
                        *)
                            echo "${RED}无效数据库类型！${NC}"
                            ;;
                    esac
                    if [ $? -eq 0 ]; then
                        echo "${GREEN}备份创建成功！${NC}"
                        echo "${YELLOW}备份文件: ${WHITE}$backup_file${NC}"
                    else
                        echo "${RED}备份创建失败！${NC}"
                    fi
                    ;;
                2)
                    read -p "${YELLOW}请输入数据库类型 (mysql/postgresql): ${NC}" db_type
                    read -p "${YELLOW}请输入用户名: ${NC}" user
                    read -s -p "${YELLOW}请输入密码: ${NC}" pass
                    echo
                    read -p "${YELLOW}请输入数据库名称: ${NC}" db
                    read -p "${YELLOW}请输入备份文件路径: ${NC}" backup_file
                    
                    echo "${YELLOW}正在恢复备份...${NC}"
                    case $db_type in
                        mysql)
                            mysql -u "$user" -p"$pass" "$db" < "$backup_file"
                            ;;
                        postgresql)
                            PGPASSWORD="$pass" psql -U "$user" -d "$db" < "$backup_file"
                            ;;
                        *)
                            echo "${RED}无效数据库类型！${NC}"
                            ;;
                    esac
                    if [ $? -eq 0 ]; then
                        echo "${GREEN}备份恢复成功！${NC}"
                    else
                        echo "${RED}备份恢复失败！${NC}"
                    fi
                    ;;
                3)
                    data_management
                    return
                    ;;
                *)
                    echo "${RED}无效选择！${NC}"
                    sleep 2
                    data_management
                    ;;
            esac
            read -p "${YELLOW}按Enter键返回...${NC}"
            data_management
            ;;
        5)
            show_title
            echo "${BLUE}数据库性能优化${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请输入数据库类型 (mysql/postgresql): ${NC}" db_type
            read -p "${YELLOW}请输入用户名: ${NC}" user
            read -s -p "${YELLOW}请输入密码: ${NC}" pass
            echo
            read -p "${YELLOW}请输入数据库名称: ${NC}" db
            
            echo "${YELLOW}正在分析数据库性能...${NC}"
            case $db_type in
                mysql)
                    mysql -u "$user" -p"$pass" "$db" -e "SHOW TABLE STATUS;"
                    mysql -u "$user" -p"$pass" "$db" -e "SHOW PROCESSLIST;"
                    ;;
                postgresql)
                    PGPASSWORD="$pass" psql -U "$user" -d "$db" -c "\dt+"
                    PGPASSWORD="$pass" psql -U "$user" -d "$db" -c "SELECT * FROM pg_stat_activity;"
                    ;;
                *)
                    echo "${RED}无效数据库类型！${NC}"
                    ;;
            esac
            echo "${YELLOW}性能优化建议:${NC}"
            echo "1. 为频繁查询的列创建索引"
            echo "2. 优化SQL查询语句"
            echo "3. 定期清理无用数据"
            echo "4. 调整数据库配置参数"
            echo "5. 考虑数据库分区"
            read -p "${YELLOW}按Enter键返回...${NC}"
            data_management
            ;;
        6)
            return
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            data_management
            ;;
    esac
}

# 4. 容器管理模块
container_management() {
    show_title
    echo "${BLUE}容器管理模块${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}Docker容器管理${NC}"
    echo "${BLUE}2. ${WHITE}Docker镜像管理${NC}"
    echo "${BLUE}3. ${WHITE}Kubernetes集群管理${NC}"
    echo "${BLUE}4. ${WHITE}容器网络配置${NC}"
    echo "${BLUE}5. ${WHITE}容器存储管理${NC}"
    echo "${BLUE}6. ${WHITE}返回上一级${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-6): ${NC}" choice
    
    case $choice in
        1)
            show_title
            echo "${BLUE}Docker容器管理${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${BLUE}1. ${WHITE}查看容器${NC}"
            echo "${BLUE}2. ${WHITE}创建容器${NC}"
            echo "${BLUE}3. ${WHITE}启动容器${NC}"
            echo "${BLUE}4. ${WHITE}停止容器${NC}"
            echo "${BLUE}5. ${WHITE}删除容器${NC}"
            echo "${BLUE}6. ${WHITE}返回上一级${NC}"
            read -p "${YELLOW}请选择操作 (1-6): ${NC}" docker_choice
            
            case $docker_choice in
                1)
                    echo "${YELLOW}正在查看容器...${NC}"
                    docker ps -a
                    ;;
                2)
                    read -p "${YELLOW}请输入镜像名称: ${NC}" image
                    read -p "${YELLOW}请输入容器名称: ${NC}" name
                    echo "${YELLOW}正在创建容器...${NC}"
                    docker run --name "$name" -d "$image"
                    ;;
                3)
                    read -p "${YELLOW}请输入容器名称或ID: ${NC}" container
                    echo "${YELLOW}正在启动容器...${NC}"
                    docker start "$container"
                    ;;
                4)
                    read -p "${YELLOW}请输入容器名称或ID: ${NC}" container
                    echo "${YELLOW}正在停止容器...${NC}"
                    docker stop "$container"
                    ;;
                5)
                    read -p "${YELLOW}请输入容器名称或ID: ${NC}" container
                    echo "${YELLOW}正在删除容器...${NC}"
                    docker rm "$container"
                    ;;
                6)
                    container_management
                    return
                    ;;
                *)
                    echo "${RED}无效选择！${NC}"
                    sleep 2
                    container_management
                    ;;
            esac
            read -p "${YELLOW}按Enter键返回...${NC}"
            container_management
            ;;
        2)
            show_title
            echo "${BLUE}Docker镜像管理${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${BLUE}1. ${WHITE}查看镜像${NC}"
            echo "${BLUE}2. ${WHITE}拉取镜像${NC}"
            echo "${BLUE}3. ${WHITE}构建镜像${NC}"
            echo "${BLUE}4. ${WHITE}删除镜像${NC}"
            echo "${BLUE}5. ${WHITE}返回上一级${NC}"
            read -p "${YELLOW}请选择操作 (1-5): ${NC}" image_choice
            
            case $image_choice in
                1)
                    echo "${YELLOW}正在查看镜像...${NC}"
                    docker images
                    ;;
                2)
                    read -p "${YELLOW}请输入镜像名称: ${NC}" image
                    echo "${YELLOW}正在拉取镜像...${NC}"
                    docker pull "$image"
                    ;;
                3)
                    read -p "${YELLOW}请输入Dockerfile路径: ${NC}" dockerfile
                    read -p "${YELLOW}请输入镜像名称: ${NC}" image
                    echo "${YELLOW}正在构建镜像...${NC}"
                    docker build -f "$dockerfile" -t "$image" .
                    ;;
                4)
                    read -p "${YELLOW}请输入镜像名称或ID: ${NC}" image
                    echo "${YELLOW}正在删除镜像...${NC}"
                    docker rmi "$image"
                    ;;
                5)
                    container_management
                    return
                    ;;
                *)
                    echo "${RED}无效选择！${NC}"
                    sleep 2
                    container_management
                    ;;
            esac
            read -p "${YELLOW}按Enter键返回...${NC}"
            container_management
            ;;
        3)
            show_title
            echo "${BLUE}Kubernetes集群管理${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${BLUE}1. ${WHITE}查看集群状态${NC}"
            echo "${BLUE}2. ${WHITE}查看Pod${NC}"
            echo "${BLUE}3. ${WHITE}查看服务${NC}"
            echo "${BLUE}4. ${WHITE}部署应用${NC}"
            echo "${BLUE}5. ${WHITE}返回上一级${NC}"
            read -p "${YELLOW}请选择操作 (1-5): ${NC}" k8s_choice
            
            case $k8s_choice in
                1)
                    echo "${YELLOW}正在查看集群状态...${NC}"
                    kubectl cluster-info
                    ;;
                2)
                    echo "${YELLOW}正在查看Pod...${NC}"
                    kubectl get pods
                    ;;
                3)
                    echo "${YELLOW}正在查看服务...${NC}"
                    kubectl get services
                    ;;
                4)
                    read -p "${YELLOW}请输入部署名称: ${NC}" deployment
                    read -p "${YELLOW}请输入镜像名称: ${NC}" image
                    read -p "${YELLOW}请输入副本数: ${NC}" replicas
                    echo "${YELLOW}正在部署应用...${NC}"
                    kubectl create deployment "$deployment" --image="$image" --replicas="$replicas"
                    ;;
                5)
                    container_management
                    return
                    ;;
                *)
                    echo "${RED}无效选择！${NC}"
                    sleep 2
                    container_management
                    ;;
            esac
            read -p "${YELLOW}按Enter键返回...${NC}"
            container_management
            ;;
        4)
            show_title
            echo "${BLUE}容器网络配置${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${BLUE}1. ${WHITE}查看网络${NC}"
            echo "${BLUE}2. ${WHITE}创建网络${NC}"
            echo "${BLUE}3. ${WHITE}删除网络${NC}"
            echo "${BLUE}4. ${WHITE}返回上一级${NC}"
            read -p "${YELLOW}请选择操作 (1-4): ${NC}" network_choice
            
            case $network_choice in
                1)
                    echo "${YELLOW}正在查看网络...${NC}"
                    docker network ls
                    ;;
                2)
                    read -p "${YELLOW}请输入网络名称: ${NC}" network
                    read -p "${YELLOW}请输入网络类型 (bridge, overlay): ${NC}" type
                    echo "${YELLOW}正在创建网络...${NC}"
                    docker network create --driver "$type" "$network"
                    ;;
                3)
                    read -p "${YELLOW}请输入网络名称: ${NC}" network
                    echo "${YELLOW}正在删除网络...${NC}"
                    docker network rm "$network"
                    ;;
                4)
                    container_management
                    return
                    ;;
                *)
                    echo "${RED}无效选择！${NC}"
                    sleep 2
                    container_management
                    ;;
            esac
            read -p "${YELLOW}按Enter键返回...${NC}"
            container_management
            ;;
        5)
            show_title
            echo "${BLUE}容器存储管理${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${BLUE}1. ${WHITE}查看卷${NC}"
            echo "${BLUE}2. ${WHITE}创建卷${NC}"
            echo "${BLUE}3. ${WHITE}删除卷${NC}"
            echo "${BLUE}4. ${WHITE}返回上一级${NC}"
            read -p "${YELLOW}请选择操作 (1-4): ${NC}" volume_choice
            
            case $volume_choice in
                1)
                    echo "${YELLOW}正在查看卷...${NC}"
                    docker volume ls
                    ;;
                2)
                    read -p "${YELLOW}请输入卷名称: ${NC}" volume
                    echo "${YELLOW}正在创建卷...${NC}"
                    docker volume create "$volume"
                    ;;
                3)
                    read -p "${YELLOW}请输入卷名称: ${NC}" volume
                    echo "${YELLOW}正在删除卷...${NC}"
                    docker volume rm "$volume"
                    ;;
                4)
                    container_management
                    return
                    ;;
                *)
                    echo "${RED}无效选择！${NC}"
                    sleep 2
                    container_management
                    ;;
            esac
            read -p "${YELLOW}按Enter键返回...${NC}"
            container_management
            ;;
        6)
            return
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            container_management
            ;;
    esac
}

# 5. 云服务集成模块
cloud_services() {
    show_title
    echo "${BLUE}云服务集成模块${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}AWS服务管理${NC}"
    echo "${BLUE}2. ${WHITE}Azure服务管理${NC}"
    echo "${BLUE}3. ${WHITE}Google Cloud服务管理${NC}"
    echo "${BLUE}4. ${WHITE}云存储管理${NC}"
    echo "${BLUE}5. ${WHITE}云资源监控${NC}"
    echo "${BLUE}6. ${WHITE}返回上一级${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-6): ${NC}" choice
    
    case $choice in
        1)
            show_title
            echo "${BLUE}AWS服务管理${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${YELLOW}AWS服务管理功能需要安装AWS CLI${NC}"
            echo "${YELLOW}请运行: pip install awscli${NC}"
            echo "${YELLOW}然后运行: aws configure${NC}"
            echo "${BLUE}1. ${WHITE}查看EC2实例${NC}"
            echo "${BLUE}2. ${WHITE}查看S3存储桶${NC}"
            echo "${BLUE}3. ${WHITE}返回上一级${NC}"
            read -p "${YELLOW}请选择操作 (1-3): ${NC}" aws_choice
            
            case $aws_choice in
                1)
                    echo "${YELLOW}正在查看EC2实例...${NC}"
                    aws ec2 describe-instances --query "Reservations[*].Instances[*].[InstanceId,State.Name,PublicIpAddress]"
                    ;;
                2)
                    echo "${YELLOW}正在查看S3存储桶...${NC}"
                    aws s3 ls
                    ;;
                3)
                    cloud_services
                    return
                    ;;
                *)
                    echo "${RED}无效选择！${NC}"
                    sleep 2
                    cloud_services
                    ;;
            esac
            read -p "${YELLOW}按Enter键返回...${NC}"
            cloud_services
            ;;
        2)
            show_title
            echo "${BLUE}Azure服务管理${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${YELLOW}Azure服务管理功能需要安装Azure CLI${NC}"
            echo "${YELLOW}请运行: curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash${NC}"
            echo "${YELLOW}然后运行: az login${NC}"
            echo "${BLUE}1. ${WHITE}查看虚拟机${NC}"
            echo "${BLUE}2. ${WHITE}查看存储账户${NC}"
            echo "${BLUE}3. ${WHITE}返回上一级${NC}"
            read -p "${YELLOW}请选择操作 (1-3): ${NC}" azure_choice
            
            case $azure_choice in
                1)
                    echo "${YELLOW}正在查看虚拟机...${NC}"
                    az vm list --output table
                    ;;
                2)
                    echo "${YELLOW}正在查看存储账户...${NC}"
                    az storage account list --output table
                    ;;
                3)
                    cloud_services
                    return
                    ;;
                *)
                    echo "${RED}无效选择！${NC}"
                    sleep 2
                    cloud_services
                    ;;
            esac
            read -p "${YELLOW}按Enter键返回...${NC}"
            cloud_services
            ;;
        3)
            show_title
            echo "${BLUE}Google Cloud服务管理${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${YELLOW}Google Cloud服务管理功能需要安装gcloud CLI${NC}"
            echo "${YELLOW}请运行: curl https://sdk.cloud.google.com | bash${NC}"
            echo "${YELLOW}然后运行: gcloud init${NC}"
            echo "${BLUE}1. ${WHITE}查看虚拟机${NC}"
            echo "${BLUE}2. ${WHITE}查看存储桶${NC}"
            echo "${BLUE}3. ${WHITE}返回上一级${NC}"
            read -p "${YELLOW}请选择操作 (1-3): ${NC}" gcp_choice
            
            case $gcp_choice in
                1)
                    echo "${YELLOW}正在查看虚拟机...${NC}"
                    gcloud compute instances list
                    ;;
                2)
                    echo "${YELLOW}正在查看存储桶...${NC}"
                    gsutil ls
                    ;;
                3)
                    cloud_services
                    return
                    ;;
                *)
                    echo "${RED}无效选择！${NC}"
                    sleep 2
                    cloud_services
                    ;;
            esac
            read -p "${YELLOW}按Enter键返回...${NC}"
            cloud_services
            ;;
        4)
            show_title
            echo "${BLUE}云存储管理${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${BLUE}1. ${WHITE}AWS S3${NC}"
            echo "${BLUE}2. ${WHITE}Azure Blob Storage${NC}"
            echo "${BLUE}3. ${WHITE}Google Cloud Storage${NC}"
            echo "${BLUE}4. ${WHITE}返回上一级${NC}"
            read -p "${YELLOW}请选择云存储服务 (1-4): ${NC}" storage_choice
            
            case $storage_choice in
                1)
                    echo "${YELLOW}AWS S3管理${NC}"
                    read -p "${YELLOW}请输入存储桶名称: ${NC}" bucket
                    echo "${YELLOW}正在查看存储桶内容...${NC}"
                    aws s3 ls "s3://$bucket/"
                    ;;
                2)
                    echo "${YELLOW}Azure Blob Storage管理${NC}"
                    read -p "${YELLOW}请输入存储账户名称: ${NC}" account
                    read -p "${YELLOW}请输入容器名称: ${NC}" container
                    echo "${YELLOW}正在查看容器内容...${NC}"
                    az storage blob list --account-name "$account" --container-name "$container" --output table
                    ;;
                3)
                    echo "${YELLOW}Google Cloud Storage管理${NC}"
                    read -p "${YELLOW}请输入存储桶名称: ${NC}" bucket
                    echo "${YELLOW}正在查看存储桶内容...${NC}"
                    gsutil ls "gs://$bucket/"
                    ;;
                4)
                    cloud_services
                    return
                    ;;
                *)
                    echo "${RED}无效选择！${NC}"
                    sleep 2
                    cloud_services
                    ;;
            esac
            read -p "${YELLOW}按Enter键返回...${NC}"
            cloud_services
            ;;
        5)
            show_title
            echo "${BLUE}云资源监控${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${BLUE}1. ${WHITE}AWS CloudWatch${NC}"
            echo "${BLUE}2. ${WHITE}Azure Monitor${NC}"
            echo "${BLUE}3. ${WHITE}Google Cloud Monitoring${NC}"
            echo "${BLUE}4. ${WHITE}返回上一级${NC}"
            read -p "${YELLOW}请选择监控服务 (1-4): ${NC}" monitor_choice
            
            case $monitor_choice in
                1)
                    echo "${YELLOW}AWS CloudWatch监控${NC}"
                    read -p "${YELLOW}请输入实例ID: ${NC}" instance
                    echo "${YELLOW}正在查看CPU使用率...${NC}"
                    aws cloudwatch get-metric-statistics --namespace AWS/EC2 --metric-name CPUUtilization --dimensions Name=InstanceId,Value="$instance" --start-time "$(date -u -d '1 hour ago' +%Y-%m-%dT%H:%M:%SZ)" --end-time "$(date -u +%Y-%m-%dT%H:%M:%SZ)" --period 3600 --statistics Average
                    ;;
                2)
                    echo "${YELLOW}Azure Monitor监控${NC}"
                    read -p "${YELLOW}请输入资源ID: ${NC}" resource
                    echo "${YELLOW}正在查看CPU使用率...${NC}"
                    az monitor metrics list --resource "$resource" --metric "Percentage CPU" --interval PT1H
                    ;;
                3)
                    echo "${YELLOW}Google Cloud Monitoring${NC}"
                    read -p "${YELLOW}请输入项目ID: ${NC}" project
                    read -p "${YELLOW}请输入实例名称: ${NC}" instance
                    echo "${YELLOW}正在查看CPU使用率...${NC}"
                    gcloud monitoring metrics list --project "$project" --filter "metric.type=\"compute.googleapis.com/instance/cpu/utilization\""
                    ;;
                4)
                    cloud_services
                    return
                    ;;
                *)
                    echo "${RED}无效选择！${NC}"
                    sleep 2
                    cloud_services
                    ;;
            esac
            read -p "${YELLOW}按Enter键返回...${NC}"
            cloud_services
            ;;
        6)
            return
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            cloud_services
            ;;
    esac
}

# 6. 网络安全模块
network_security() {
    show_title
    echo "${BLUE}网络安全模块${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}端口扫描和安全检测${NC}"
    echo "${BLUE}2. ${WHITE}防火墙配置和管理${NC}"
    echo "${BLUE}3. ${WHITE}入侵检测系统${NC}"
    echo "${BLUE}4. ${WHITE}网络流量分析${NC}"
    echo "${BLUE}5. ${WHITE}SSL证书管理${NC}"
    echo "${BLUE}6. ${WHITE}返回上一级${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-6): ${NC}" choice
    
    case $choice in
        1)
            show_title
            echo "${BLUE}端口扫描和安全检测${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请输入目标IP或域名: ${NC}" target      
            echo "${YELLOW}正在进行端口扫描...${NC}"
            if command -v nmap &> /dev/null; then
                nmap "$target"
            else
                echo "${RED}nmap未安装，请先安装nmap${NC}"
            fi
            read -p "${YELLOW}按Enter键返回...${NC}"
            network_security
            ;;
        2)
            show_title
            echo "${BLUE}防火墙配置和管理${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${BLUE}1. ${WHITE}查看防火墙状态${NC}"
            echo "${BLUE}2. ${WHITE}启用防火墙${NC}"
            echo "${BLUE}3. ${WHITE}禁用防火墙${NC}"
            echo "${BLUE}4. ${WHITE}添加规则${NC}"
            echo "${BLUE}5. ${WHITE}返回上一级${NC}"
            read -p "${YELLOW}请选择操作 (1-5): ${NC}" firewall_choice      

            case $firewall_choice in
                1)
                    echo "${YELLOW}正在查看防火墙状态...${NC}"
                    if command -v ufw &> /dev/null; then
                        ufw status
                    elif command -v iptables &> /dev/null; then
                        iptables -L
                    else
                        echo "${RED}防火墙工具未安装${NC}"
                    fi
                    ;;
                2)
                    echo "${YELLOW}正在启用防火墙...${NC}"
                    if command -v ufw &> /dev/null; then
                        ufw enable
                    elif command -v systemctl &> /dev/null; then
                        systemctl start firewalld
                    else
                        echo "${RED}防火墙工具未安装${NC}"
                    fi
                    ;;
                3)
                    echo "${YELLOW}正在禁用防火墙...${NC}"
                    if command -v ufw &> /dev/null; then
                        ufw disable
                    elif command -v systemctl &> /dev/null; then
                        systemctl stop firewalld
                    else
                        echo "${RED}防火墙工具未安装${NC}"
                    fi
                    ;;
                4)
                    read -p "${YELLOW}请输入端口: ${NC}" port
                    read -p "${YELLOW}请输入协议(tcp/udp): ${NC}" proto    
                    echo "${YELLOW}正在添加防火墙规则...${NC}"
                    if command -v ufw &> /dev/null; then
                        ufw allow "$port/$proto"
                    elif command -v iptables &> /dev/null; then
                        iptables -A INPUT -p "$proto" --dport "$port" -j ACCEPT 
                    else
                        echo "${RED}防火墙工具未安装${NC}"
                    fi
                    ;;
                5)
                    network_security
                    return
                    ;;
                *)
                    echo "${RED}无效选择！${NC}"
                    sleep 2
                    network_security
                    ;;
            esac
            read -p "${YELLOW}按Enter键返回...${NC}"
            network_security
            ;;
        3)
            show_title
            echo "${BLUE}入侵检测系统${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${YELLOW}入侵检测系统功能需要安装Snort或Suricata${NC}"
            echo "${YELLOW}请运行: sudo apt install snort${NC}"
            echo "${YELLOW}或: sudo apt install suricata${NC}"
            echo "${BLUE}1. ${WHITE}启动Snort${NC}"
            echo "${BLUE}2. ${WHITE}启动Suricata${NC}"
            echo "${BLUE}3. ${WHITE}返回上一级${NC}"
            read -p "${YELLOW}请选择操作 (1-3): ${NC}" ids_choice

            case $ids_choice in
                1)
                    echo "${YELLOW}正在启动Snort...${NC}"
                    if command -v snort &> /dev/null; then
                        snort -A console -i eth0 -c /etc/snort/snort.conf       
                    else
                        echo "${RED}Snort未安装${NC}"
                    fi
                    ;;
                2)
                    echo "${YELLOW}正在启动Suricata...${NC}"
                    if command -v suricata &> /dev/null; then
                        suricata -i eth0
                    else
                        echo "${RED}Suricata未安装${NC}"
                    fi
                    ;;
                3)
                    network_security
                    return
                    ;;
                *)
                    echo "${RED}无效选择！${NC}"
                    sleep 2
                    network_security
                    ;;
            esac
            read -p "${YELLOW}按Enter键返回...${NC}"
            network_security
            ;;
        4)
            show_title
            echo "${BLUE}网络流量分析${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${BLUE}1. ${WHITE}查看网络连接${NC}"
            echo "${BLUE}2. ${WHITE}使用tcpdump抓包${NC}"
            echo "${BLUE}3. ${WHITE}返回上一级${NC}"
            read -p "${YELLOW}请选择操作 (1-3): ${NC}" traffic_choice       

            case $traffic_choice in
                1)
                    echo "${YELLOW}正在查看网络连接...${NC}"
                    netstat -tuln
                    ;;
                2)
                    read -p "${YELLOW}请输入网络接口: ${NC}" interface    
                    echo "${YELLOW}正在使用tcpdump抓包...${NC}"
                    echo "${YELLOW}按 Ctrl+C 停止${NC}"
                    tcpdump -i "$interface"
                    ;;
                3)
                    network_security
                    return
                    ;;
                *)
                    echo "${RED}无效选择！${NC}"
                    sleep 2
                    network_security
                    ;;
            esac
            read -p "${YELLOW}按Enter键返回...${NC}"
            network_security
            ;;
        5)
            show_title
            echo "${BLUE}SSL证书管理${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${BLUE}1. ${WHITE}生成自签名证书${NC}"
            echo "${BLUE}2. ${WHITE}查看证书信息${NC}"
            echo "${BLUE}3. ${WHITE}返回上一级${NC}"
            read -p "${YELLOW}请选择操作 (1-3): ${NC}" ssl_choice

            case $ssl_choice in
                1)
                    read -p "${YELLOW}请输入域名: ${NC}" domain
                    read -p "${YELLOW}请输入输出目录: ${NC}" output_dir   
                    mkdir -p "$output_dir"
                    echo "${YELLOW}正在生成自签名证书...${NC}"
                    openssl req -x509 -newkey rsa:2048 -keyout "$output_dir/private.key" -out "$output_dir/certificate.crt" -days 365 -nodes -subj "/CN=$domain"
                    if [ $? -eq 0 ]; then
                        echo "${GREEN}自签名证书生成成功！${NC}"        
                        echo "${YELLOW}私钥文件: ${WHITE}$output_dir/private.key${NC}"
                        echo "${YELLOW}证书文件: ${WHITE}$output_dir/certificate.crt${NC}"
                    else
                        echo "${RED}自签名证书生成失败！${NC}"
                    fi
                    ;;
                2)
                    read -p "${YELLOW}请输入证书文件路径: ${NC}" cert_file
                    echo "${YELLOW}正在查看证书信息...${NC}"
                    openssl x509 -in "$cert_file" -text -noout
                    ;;
                3)
                    network_security
                    return
                    ;;
                *)
                    echo "${RED}无效选择！${NC}"
                    sleep 2
                    network_security
                    ;;
            esac
            read -p "${YELLOW}按Enter键返回...${NC}"
            network_security
            ;;
        6