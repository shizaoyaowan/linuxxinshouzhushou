#!/bin/bash

# 高级工具模块

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
    echo "${YELLOW}        Linux高级工具模块${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}高级系统管理工具集${NC}"
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

# 1. 文件批量操作工具
batch_file_operations() {
    show_title
    echo "${BLUE}文件批量操作工具${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}批量重命名${NC}"
    echo "${BLUE}2. ${WHITE}批量移动${NC}"
    echo "${BLUE}3. ${WHITE}批量复制${NC}"
    echo "${BLUE}4. ${WHITE}批量删除${NC}"
    echo "${BLUE}5. ${WHITE}返回上一级${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-5): ${NC}" choice
    
    case $choice in
        1)
            show_title
            echo "${BLUE}批量重命名${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请输入文件匹配模式 (如: *.jpg): ${NC}" pattern
            read -p "${YELLOW}请输入新文件名模式 (如: photo_##.jpg): ${NC}" new_pattern
            
            echo "${YELLOW}正在预览重命名结果...${NC}"
            i=1
            for file in $pattern; do
                if [ -f "$file" ]; then
                    new_name=$(echo "$new_pattern" | sed "s/##/$i/")
                    echo "${WHITE}$file${NC} → ${GREEN}$new_name${NC}"
                    i=$((i+1))
                fi
            done
            
            read -p "${YELLOW}确定执行重命名吗？(y/n): ${NC}" confirm
            if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
                i=1
                for file in $pattern; do
                    if [ -f "$file" ]; then
                        new_name=$(echo "$new_pattern" | sed "s/##/$i/")
                        mv "$file" "$new_name"
                        i=$((i+1))
                    fi
                done
                echo "${GREEN}批量重命名完成！${NC}"
            else
                echo "${YELLOW}取消操作${NC}"
            fi
            read -p "${YELLOW}按Enter键返回...${NC}"
            batch_file_operations
            ;;
        2)
            show_title
            echo "${BLUE}批量移动${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请输入文件匹配模式 (如: *.jpg): ${NC}" pattern
            read -p "${YELLOW}请输入目标目录: ${NC}" target_dir
            
            if [ ! -d "$target_dir" ]; then
                read -p "${YELLOW}目标目录不存在，是否创建？(y/n): ${NC}" create
                if [ "$create" = "y" ] || [ "$create" = "Y" ]; then
                    mkdir -p "$target_dir"
                else
                    echo "${RED}操作取消${NC}"
                    read -p "${YELLOW}按Enter键返回...${NC}"
                    batch_file_operations
                    return
                fi
            fi
            
            echo "${YELLOW}正在预览移动结果...${NC}"
            for file in $pattern; do
                if [ -f "$file" ]; then
                    echo "${WHITE}$file${NC} → ${GREEN}$target_dir/$(basename "$file")${NC}"
                fi
            done
            
            read -p "${YELLOW}确定执行移动吗？(y/n): ${NC}" confirm
            if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
                for file in $pattern; do
                    if [ -f "$file" ]; then
                        mv "$file" "$target_dir/"
                    fi
                done
                echo "${GREEN}批量移动完成！${NC}"
            else
                echo "${YELLOW}取消操作${NC}"
            fi
            read -p "${YELLOW}按Enter键返回...${NC}"
            batch_file_operations
            ;;
        3)
            show_title
            echo "${BLUE}批量复制${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请输入文件匹配模式 (如: *.jpg): ${NC}" pattern
            read -p "${YELLOW}请输入目标目录: ${NC}" target_dir
            
            if [ ! -d "$target_dir" ]; then
                read -p "${YELLOW}目标目录不存在，是否创建？(y/n): ${NC}" create
                if [ "$create" = "y" ] || [ "$create" = "Y" ]; then
                    mkdir -p "$target_dir"
                else
                    echo "${RED}操作取消${NC}"
                    read -p "${YELLOW}按Enter键返回...${NC}"
                    batch_file_operations
                    return
                fi
            fi
            
            echo "${YELLOW}正在预览复制结果...${NC}"
            for file in $pattern; do
                if [ -f "$file" ]; then
                    echo "${WHITE}$file${NC} → ${GREEN}$target_dir/$(basename "$file")${NC}"
                fi
            done
            
            read -p "${YELLOW}确定执行复制吗？(y/n): ${NC}" confirm
            if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
                for file in $pattern; do
                    if [ -f "$file" ]; then
                        cp "$file" "$target_dir/"
                    fi
                done
                echo "${GREEN}批量复制完成！${NC}"
            else
                echo "${YELLOW}取消操作${NC}"
            fi
            read -p "${YELLOW}按Enter键返回...${NC}"
            batch_file_operations
            ;;
        4)
            show_title
            echo "${BLUE}批量删除${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请输入文件匹配模式 (如: *.tmp): ${NC}" pattern
            
            echo "${YELLOW}以下文件将被删除:${NC}"
            for file in $pattern; do
                if [ -f "$file" ]; then
                    echo "${RED}$file${NC}"
                fi
            done
            
            read -p "${YELLOW}确定执行删除吗？(y/n): ${NC}" confirm
            if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
                for file in $pattern; do
                    if [ -f "$file" ]; then
                        rm "$file"
                    fi
                done
                echo "${GREEN}批量删除完成！${NC}"
            else
                echo "${YELLOW}取消操作${NC}"
            fi
            read -p "${YELLOW}按Enter键返回...${NC}"
            batch_file_operations
            ;;
        5)
            return
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            batch_file_operations
            ;;
    esac
}

# 2. 系统备份和恢复
system_backup() {
    show_title
    echo "${BLUE}系统备份和恢复${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}创建备份${NC}"
    echo "${BLUE}2. ${WHITE}恢复备份${NC}"
    echo "${BLUE}3. ${WHITE}管理备份${NC}"
    echo "${BLUE}4. ${WHITE}返回上一级${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-4): ${NC}" choice
    
    case $choice in
        1)
            show_title
            echo "${BLUE}创建备份${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请输入备份名称: ${NC}" backup_name
            read -p "${YELLOW}请输入备份目录: ${NC}" backup_dir
            
            if [ ! -d "$backup_dir" ]; then
                mkdir -p "$backup_dir"
            fi
            
            backup_file="$backup_dir/${backup_name}_$(date +%Y%m%d_%H%M%S).tar.gz"
            
            echo "${YELLOW}正在创建备份...${NC}"
            echo "${YELLOW}备份文件: ${WHITE}$backup_file${NC}"
            
            # 备份重要配置文件
            tar -czf "$backup_file" /etc /home 2>/dev/null
            
            if [ $? -eq 0 ]; then
                echo "${GREEN}备份创建成功！${NC}"
                echo "${YELLOW}备份大小: $(du -h "$backup_file" | cut -f1)${NC}"
            else
                echo "${RED}备份创建失败！${NC}"
            fi
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            system_backup
            ;;
        2)
            show_title
            echo "${BLUE}恢复备份${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请输入备份文件路径: ${NC}" backup_file
            
            if [ ! -f "$backup_file" ]; then
                echo "${RED}备份文件不存在！${NC}"
                read -p "${YELLOW}按Enter键返回...${NC}"
                system_backup
                return
            fi
            
            echo "${YELLOW}正在恢复备份...${NC}"
            echo "${RED}警告: 恢复备份会覆盖现有文件！${NC}"
            read -p "${YELLOW}确定继续吗？(y/n): ${NC}" confirm
            
            if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
                tar -xzf "$backup_file" -C /
                if [ $? -eq 0 ]; then
                    echo "${GREEN}备份恢复成功！${NC}"
                else
                    echo "${RED}备份恢复失败！${NC}"
                fi
            else
                echo "${YELLOW}取消操作${NC}"
            fi
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            system_backup
            ;;
        3)
            show_title
            echo "${BLUE}管理备份${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请输入备份目录: ${NC}" backup_dir
            
            if [ ! -d "$backup_dir" ]; then
                echo "${RED}备份目录不存在！${NC}"
                read -p "${YELLOW}按Enter键返回...${NC}"
                system_backup
                return
            fi
            
            echo "${YELLOW}备份文件列表:${NC}"
            ls -la "$backup_dir" | grep .tar.gz
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            system_backup
            ;;
        4)
            return
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            system_backup
            ;;
    esac
}

# 3. 网络配置向导
network_config_wizard() {
    show_title
    echo "${BLUE}网络配置向导${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}查看网络接口${NC}"
    echo "${BLUE}2. ${WHITE}设置静态IP${NC}"
    echo "${BLUE}3. ${WHITE}设置DNS${NC}"
    echo "${BLUE}4. ${WHITE}网络测试${NC}"
    echo "${BLUE}5. ${WHITE}返回上一级${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-5): ${NC}" choice
    
    case $choice in
        1)
            show_title
            echo "${BLUE}网络接口信息${NC}"
            echo "${GREEN}=======================================${NC}"
            if command -v ifconfig &> /dev/null; then
                ifconfig
            elif command -v ip &> /dev/null; then
                ip addr
            else
                echo "${RED}网络命令未安装${NC}"
            fi
            read -p "${YELLOW}按Enter键返回...${NC}"
            network_config_wizard
            ;;
        2)
            show_title
            echo "${BLUE}设置静态IP${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请输入网络接口 (如: eth0): ${NC}" interface
            read -p "${YELLOW}请输入IP地址 (如: 192.168.1.100): ${NC}" ip_address
            read -p "${YELLOW}请输入子网掩码 (如: 255.255.255.0): ${NC}" netmask
            read -p "${YELLOW}请输入网关 (如: 192.168.1.1): ${NC}" gateway
            
            echo "${YELLOW}正在设置静态IP...${NC}"
            
            # 备份网络配置
            if [ -f "/etc/network/interfaces" ]; then
                cp /etc/network/interfaces /etc/network/interfaces.bak
            fi
            
            # 写入新配置
            cat > /etc/network/interfaces << EOF
auto lo
iface lo inet loopback

auto $interface
iface $interface inet static
    address $ip_address
    netmask $netmask
    gateway $gateway
EOF
            
            # 重启网络
            if command -v systemctl &> /dev/null; then
                systemctl restart networking
            else
                service networking restart
            fi
            
            echo "${GREEN}静态IP设置完成！${NC}"
            read -p "${YELLOW}按Enter键返回...${NC}"
            network_config_wizard
            ;;
        3)
            show_title
            echo "${BLUE}设置DNS${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请输入主DNS服务器: ${NC}" dns1
            read -p "${YELLOW}请输入备用DNS服务器: ${NC}" dns2
            
            echo "${YELLOW}正在设置DNS...${NC}"
            
            # 备份DNS配置
            if [ -f "/etc/resolv.conf" ]; then
                cp /etc/resolv.conf /etc/resolv.conf.bak
            fi
            
            # 写入新配置
            cat > /etc/resolv.conf << EOF
nameserver $dns1
nameserver $dns2
EOF
            
            echo "${GREEN}DNS设置完成！${NC}"
            read -p "${YELLOW}按Enter键返回...${NC}"
            network_config_wizard
            ;;
        4)
            show_title
            echo "${BLUE}网络测试${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请输入要测试的网站地址: ${NC}" website
            
            echo "${YELLOW}正在测试网络连接...${NC}"
            ping -c 4 "$website"
            
            echo "${YELLOW}正在测试DNS解析...${NC}"
            nslookup "$website"
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            network_config_wizard
            ;;
        5)
            return
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            network_config_wizard
            ;;
    esac
}

# 4. 用户管理工具
user_management() {
    show_title
    echo "${BLUE}用户管理工具${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}创建用户${NC}"
    echo "${BLUE}2. ${WHITE}修改用户密码${NC}"
    echo "${BLUE}3. ${WHITE}管理用户组${NC}"
    echo "${BLUE}4. ${WHITE}查看用户信息${NC}"
    echo "${BLUE}5. ${WHITE}删除用户${NC}"
    echo "${BLUE}6. ${WHITE}返回上一级${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-6): ${NC}" choice
    
    case $choice in
        1)
            show_title
            echo "${BLUE}创建用户${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请输入用户名: ${NC}" username
            read -s -p "${YELLOW}请输入密码: ${NC}" password
            echo
            echo "${YELLOW}正在创建用户...${NC}"
            useradd "$username"
            echo "$username:$password" | chpasswd
            
            if [ $? -eq 0 ]; then
                echo "${GREEN}用户创建成功！${NC}"
            else
                echo "${RED}用户创建失败！${NC}"
            fi
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            user_management
            ;;
        2)
            show_title
            echo "${BLUE}修改用户密码${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请输入用户名: ${NC}" username
            read -s -p "${YELLOW}请输入新密码: ${NC}" password
            echo
            echo "${YELLOW}正在修改密码...${NC}"
            echo "$username:$password" | chpasswd
            
            if [ $? -eq 0 ]; then
                echo "${GREEN}密码修改成功！${NC}"
            else
                echo "${RED}密码修改失败！${NC}"
            fi
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            user_management
            ;;
        3)
            show_title
            echo "${BLUE}管理用户组${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${BLUE}1. ${WHITE}创建用户组${NC}"
            echo "${BLUE}2. ${WHITE}添加用户到组${NC}"
            echo "${BLUE}3. ${WHITE}从组中移除用户${NC}"
            echo "${BLUE}4. ${WHITE}查看用户组${NC}"
            echo "${BLUE}5. ${WHITE}返回上一级${NC}"
            read -p "${YELLOW}请选择操作 (1-5): ${NC}" group_choice
            
            case $group_choice in
                1)
                    read -p "${YELLOW}请输入用户组名称: ${NC}" groupname
                    echo "${YELLOW}正在创建用户组...${NC}"
                    groupadd "$groupname"
                    if [ $? -eq 0 ]; then
                        echo "${GREEN}用户组创建成功！${NC}"
                    else
                        echo "${RED}用户组创建失败！${NC}"
                    fi
                    read -p "${YELLOW}按Enter键返回...${NC}"
                    user_management
                    ;;
                2)
                    read -p "${YELLOW}请输入用户名: ${NC}" username
                    read -p "${YELLOW}请输入用户组名称: ${NC}" groupname
                    echo "${YELLOW}正在添加用户到组...${NC}"
                    usermod -a -G "$groupname" "$username"
                    if [ $? -eq 0 ]; then
                        echo "${GREEN}用户添加到组成功！${NC}"
                    else
                        echo "${RED}用户添加到组失败！${NC}"
                    fi
                    read -p "${YELLOW}按Enter键返回...${NC}"
                    user_management
                    ;;
                3)
                    read -p "${YELLOW}请输入用户名: ${NC}" username
                    read -p "${YELLOW}请输入用户组名称: ${NC}" groupname
                    echo "${YELLOW}正在从组中移除用户...${NC}"
                    gpasswd -d "$username" "$groupname"
                    if [ $? -eq 0 ]; then
                        echo "${GREEN}用户从组中移除成功！${NC}"
                    else
                        echo "${RED}用户从组中移除失败！${NC}"
                    fi
                    read -p "${YELLOW}按Enter键返回...${NC}"
                    user_management
                    ;;
                4)
                    echo "${YELLOW}用户组列表:${NC}"
                    cat /etc/group
                    read -p "${YELLOW}按Enter键返回...${NC}"
                    user_management
                    ;;
                5)
                    user_management
                    ;;
                *)
                    echo "${RED}无效选择，请重新输入！${NC}"
                    sleep 2
                    user_management
                    ;;
            esac
            ;;
        4)
            show_title
            echo "${BLUE}查看用户信息${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请输入用户名: ${NC}" username
            echo "${YELLOW}用户信息:${NC}"
            id "$username"
            echo "${YELLOW}用户所属组:${NC}"
            groups "$username"
            read -p "${YELLOW}按Enter键返回...${NC}"
            user_management
            ;;
        5)
            show_title
            echo "${BLUE}删除用户${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请输入用户名: ${NC}" username
            echo "${RED}警告: 删除用户将同时删除用户的主目录！${NC}"
            read -p "${YELLOW}确定删除用户 $username 吗？(y/n): ${NC}" confirm
            
            if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
                echo "${YELLOW}正在删除用户...${NC}"
                userdel -r "$username"
                if [ $? -eq 0 ]; then
                    echo "${GREEN}用户删除成功！${NC}"
                else
                    echo "${RED}用户删除失败！${NC}"
                fi
            else
                echo "${YELLOW}取消操作${NC}"
            fi
            read -p "${YELLOW}按Enter键返回...${NC}"
            user_management
            ;;
        6)
            return
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            user_management
            ;;
    esac
}

# 5. 系统日志分析
system_log_analysis() {
    show_title
    echo "${BLUE}系统日志分析${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}查看错误日志${NC}"
    echo "${BLUE}2. ${WHITE}查看警告日志${NC}"
    echo "${BLUE}3. ${WHITE}搜索日志${NC}"
    echo "${BLUE}4. ${WHITE}实时日志监控${NC}"
    echo "${BLUE}5. ${WHITE}返回上一级${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-5): ${NC}" choice
    
    case $choice in
        1)
            show_title
            echo "${BLUE}错误日志分析${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${YELLOW}最近的错误日志:${NC}"
            grep -r "ERROR" /var/log/ 2>/dev/null | tail -20
            read -p "${YELLOW}按Enter键返回...${NC}"
            system_log_analysis
            ;;
        2)
            show_title
            echo "${BLUE}警告日志分析${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${YELLOW}最近的警告日志:${NC}"
            grep -r "WARNING" /var/log/ 2>/dev/null | tail -20
            read -p "${YELLOW}按Enter键返回...${NC}"
            system_log_analysis
            ;;
        3)
            show_title
            echo "${BLUE}搜索日志${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请输入搜索关键词: ${NC}" keyword
            echo "${YELLOW}搜索结果:${NC}"
            grep -r "$keyword" /var/log/ 2>/dev/null | tail -20
            read -p "${YELLOW}按Enter键返回...${NC}"
            system_log_analysis
            ;;
        4)
            show_title
            echo "${BLUE}实时日志监控${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${YELLOW}实时监控系统日志...${NC}"
            echo "${YELLOW}按 Ctrl+C 退出${NC}"
            tail -f /var/log/syslog
            read -p "${YELLOW}按Enter键返回...${NC}"
            system_log_analysis
            ;;
        5)
            return
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            system_log_analysis
            ;;
    esac
}

# 6. 系统性能调优
system_performance() {
    show_title
    echo "${BLUE}系统性能调优${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}查看系统性能${NC}"
    echo "${BLUE}2. ${WHITE}一键优化${NC}"
    echo "${BLUE}3. ${WHITE}内存优化${NC}"
    echo "${BLUE}4. ${WHITE}磁盘优化${NC}"
    echo "${BLUE}5. ${WHITE}返回上一级${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-5): ${NC}" choice
    
    case $choice in
        1)
            show_title
            echo "${BLUE}系统性能分析${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${YELLOW}CPU使用情况:${NC}"
            top -bn1 | head -20
            echo "${GREEN}=======================================${NC}"
            echo "${YELLOW}内存使用情况:${NC}"
            free -h
            echo "${GREEN}=======================================${NC}"
            echo "${YELLOW}磁盘使用情况:${NC}"
            df -h
            read -p "${YELLOW}按Enter键返回...${NC}"
            system_performance
            ;;
        2)
            show_title
            echo "${BLUE}一键优化${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${YELLOW}正在优化系统性能...${NC}"
            
            # 清理系统垃圾
            echo "${YELLOW}清理系统垃圾...${NC}"
            apt autoclean 2>/dev/null
            apt autoremove -y 2>/dev/null
            
            # 清理内存
            echo "${YELLOW}清理内存...${NC}"
            sync
            echo 3 > /proc/sys/vm/drop_caches 2>/dev/null
            
            # 优化磁盘
            echo "${YELLOW}优化磁盘...${NC}"
            hdparm -t /dev/sda 2>/dev/null
            
            echo "${GREEN}系统优化完成！${NC}"
            read -p "${YELLOW}按Enter键返回...${NC}"
            system_performance
            ;;
        3)
            show_title
            echo "${BLUE}内存优化${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${YELLOW}当前内存使用情况:${NC}"
            free -h
            echo "${YELLOW}正在清理内存...${NC}"
            sync
            echo 3 > /proc/sys/vm/drop_caches 2>/dev/null
            echo "${YELLOW}清理后内存使用情况:${NC}"
            free -h
            read -p "${YELLOW}按Enter键返回...${NC}"
            system_performance
            ;;
        4)
            show_title
            echo "${BLUE}磁盘优化${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${YELLOW}磁盘使用情况:${NC}"
            df -h
            echo "${YELLOW}正在优化磁盘...${NC}"
            if command -v fstrim &> /dev/null; then
                fstrim -v / 2>/dev/null
            fi
            echo "${YELLOW}磁盘速度测试:${NC}"
            hdparm -t /dev/sda 2>/dev/null
            read -p "${YELLOW}按Enter键返回...${NC}"
            system_performance
            ;;
        5)
            return
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            system_performance
            ;;
    esac
}

# 7. 应用程序管理
application_management() {
    show_title
    echo "${BLUE}应用程序管理${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}查看已安装应用${NC}"
    echo "${BLUE}2. ${WHITE}启动应用${NC}"
    echo "${BLUE}3. ${WHITE}卸载应用${NC}"
    echo "${BLUE}4. ${WHITE}搜索应用${NC}"
    echo "${BLUE}5. ${WHITE}返回上一级${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-5): ${NC}" choice
    
    case $choice in
        1)
            show_title
            echo "${BLUE}已安装应用列表${NC}"
            echo "${GREEN}=======================================${NC}"
            if command -v dpkg &> /dev/null; then
                dpkg -l | head -20
            elif command -v rpm &> /dev/null; then
                rpm -qa | head -20
            else
                echo "${RED}无法列出已安装应用${NC}"
            fi
            read -p "${YELLOW}按Enter键返回...${NC}"
            application_management
            ;;
        2)
            show_title
            echo "${BLUE}启动应用${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请输入应用名称: ${NC}" app_name
            echo "${YELLOW}正在启动应用...${NC}"
            $app_name & 2>/dev/null
            if [ $? -eq 0 ]; then
                echo "${GREEN}应用启动成功！${NC}"
            else
                echo "${RED}应用启动失败或应用不存在！${NC}"
            fi
            read -p "${YELLOW}按Enter键返回...${NC}"
            application_management
            ;;
        3)
            show_title
            echo "${BLUE}卸载应用${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请输入应用名称: ${NC}" app_name
            echo "${YELLOW}正在卸载应用...${NC}"
            if command -v apt &> /dev/null; then
                apt remove -y "$app_name"
            elif command -v yum &> /dev/null; then
                yum remove -y "$app_name"
            else
                echo "${RED}无法卸载应用${NC}"
            fi
            read -p "${YELLOW}按Enter键返回...${NC}"
            application_management
            ;;
        4)
            show_title
            echo "${BLUE}搜索应用${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请输入应用名称: ${NC}" app_name
            echo "${YELLOW}正在搜索应用...${NC}"
            if command -v apt &> /dev/null; then
                apt search "$app_name"
            elif command -v yum &> /dev/null; then
                yum search "$app_name"
            else
                echo "${RED}无法搜索应用${NC}"
            fi
            read -p "${YELLOW}按Enter键返回...${NC}"
            application_management
            ;;
        5)
            return
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            application_management
            ;;
    esac
}

# 8. 远程连接管理
remote_connection() {
    show_title
    echo "${BLUE}远程连接管理${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}SSH连接${NC}"
    echo "${BLUE}2. ${WHITE}VNC连接${NC}"
    echo "${BLUE}3. ${WHITE}保存连接配置${NC}"
    echo "${BLUE}4. ${WHITE}查看连接历史${NC}"
    echo "${BLUE}5. ${WHITE}返回上一级${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-5): ${NC}" choice
    
    case $choice in
        1)
            show_title
            echo "${BLUE}SSH连接${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请输入用户名: ${NC}" username
            read -p "${YELLOW}请输入主机IP: ${NC}" host
            echo "${YELLOW}正在连接...${NC}"
            echo "${WHITE}命令: ssh $username@$host${NC}"
            read -p "${YELLOW}按Enter键返回...${NC}"
            remote_connection
            ;;
        2)
            show_title
            echo "${BLUE}VNC连接${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请输入主机IP: ${NC}" host
            read -p "${YELLOW}请输入端口 (默认 5901): ${NC}" port
            port=${port:-5901}
            echo "${YELLOW}正在连接...${NC}"
            echo "${WHITE}连接地址: $host:$port${NC}"
            read -p "${YELLOW}按Enter键返回...${NC}"
            remote_connection
            ;;
        3)
            show_title
            echo "${BLUE}保存连接配置${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请输入连接名称: ${NC}" name
            read -p "${YELLOW}请输入用户名: ${NC}" username
            read -p "${YELLOW}请输入主机IP: ${NC}" host
            read -p "${YELLOW}请输入端口: ${NC}" port
            
            mkdir -p ~/.linux助手/connections
            echo "name=$name
username=$username
host=$host
port=$port" > ~/.linux助手/connections/$name.conf
            echo "${GREEN}连接配置保存成功！${NC}"
            read -p "${YELLOW}按Enter键返回...${NC}"
            remote_connection
            ;;
        4)
            show_title
            echo "${BLUE}连接历史${NC}"
            echo "${GREEN}=======================================${NC}"
            if [ -d ~/.linux助手/connections ]; then
                ls -la ~/.linux助手/connections/
            else
                echo "${YELLOW}没有保存的连接配置${NC}"
            fi
            read -p "${YELLOW}按Enter键返回...${NC}"
            remote_connection
            ;;
        5)
            return
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            remote_connection
            ;;
    esac
}

# 9. 系统安全工具
system_security() {
    show_title
    echo "${BLUE}系统安全工具${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}安全扫描${NC}"
    echo "${BLUE}2. ${WHITE}防火墙配置${NC}"
    echo "${BLUE}3. ${WHITE}SSH安全配置${NC}"
    echo "${BLUE}4. ${WHITE}安全建议${NC}"
    echo "${BLUE}5. ${WHITE}返回上一级${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-5): ${NC}" choice
    
    case $choice in
        1)
            show_title
            echo "${BLUE}安全扫描${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${YELLOW}正在扫描系统安全...${NC}"
            
            # 检查系统更新
            echo "${YELLOW}检查系统更新...${NC}"
            apt update 2>/dev/null
            
            # 检查开放端口
            echo "${YELLOW}检查开放端口...${NC}"
            netstat -tuln 2>/dev/null || ss -tuln 2>/dev/null
            
            # 检查用户账户
            echo "${YELLOW}检查用户账户...${NC}"
            cat /etc/passwd | grep -v nologin
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            system_security
            ;;
        2)
            show_title
            echo "${BLUE}防火墙配置${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${YELLOW}当前防火墙状态:${NC}"
            if command -v ufw &> /dev/null; then
                ufw status
            elif command -v iptables &> /dev/null; then
                iptables -L
            else
                echo "${RED}防火墙工具未安装${NC}"
            fi
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            system_security
            ;;
        3)
            show_title
            echo "${BLUE}SSH安全配置${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${YELLOW}当前SSH配置:${NC}"
            cat /etc/ssh/sshd_config | grep -v "^#"
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            system_security
            ;;
        4)
            show_title
            echo "${BLUE}安全建议${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${YELLOW}系统安全建议:${NC}"
            echo "1. 定期更新系统: sudo apt update && sudo apt upgrade"
            echo "2. 启用防火墙: sudo ufw enable"
            echo "3. 禁用root远程登录: 修改 /etc/ssh/sshd_config"
            echo "4. 使用SSH密钥认证: ssh-keygen"
            echo "5. 定期检查系统日志: journalctl"
            echo "6. 安装防病毒软件: sudo apt install clamav"
            echo "7. 设置强密码策略: 修改 /etc/login.defs"
            echo "8. 定期备份系统: 使用备份工具"
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            system_security
            ;;
        5)
            return
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            system_security
            ;;
    esac
}

# 10. 环境变量管理
environment_variables() {
    show_title
    echo "${BLUE}环境变量管理${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}查看环境变量${NC}"
    echo "${BLUE}2. ${WHITE}设置环境变量${NC}"
    echo "${BLUE}3. ${WHITE}导出环境变量${NC}"
    echo "${BLUE}4. ${WHITE}导入环境变量${NC}"
    echo "${BLUE}5. ${WHITE}返回上一级${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-5): ${NC}" choice
    
    case $choice in
        1)
            show_title
            echo "${BLUE}环境变量列表${NC}"
            echo "${GREEN}=======================================${NC}"
            env | head -30
            read -p "${YELLOW}按Enter键返回...${NC}"
            environment_variables
            ;;
        2)
            show_title
            echo "${BLUE}设置环境变量${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请输入变量名: ${NC}" var_name
            read -p "${YELLOW}请输入变量值: ${NC}" var_value
            
            echo "${YELLOW}正在设置环境变量...${NC}"
            export "$var_name"="$var_value"
            echo "${GREEN}环境变量设置成功！${NC}"
            echo "${YELLOW}${var_name}=${var_value}${NC}"
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            environment_variables
            ;;
        3)
            show_title
            echo "${BLUE}导出环境变量${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请输入导出文件名: ${NC}" export_file
            
            echo "${YELLOW}正在导出环境变量...${NC}"
            env > "$export_file"
            echo "${GREEN}环境变量导出成功！${NC}"
            echo "${YELLOW}导出文件: ${WHITE}$export_file${NC}"
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            environment_variables
            ;;
        4)
            show_title
            echo "${BLUE}导入环境变量${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请输入导入文件名: ${NC}" import_file
            
            if [ ! -f "$import_file" ]; then
                echo "${RED}导入文件不存在！${NC}"
                read -p "${YELLOW}按Enter键返回...${NC}"
                environment_variables
                return
            fi
            
            echo "${YELLOW}正在导入环境变量...${NC}"
            source "$import_file"
            echo "${GREEN}环境变量导入成功！${NC}"
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            environment_variables
            ;;
        5)
            return
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            environment_variables
            ;;
    esac
}

# 主菜单
show_main_menu() {
    show_title
    echo "${BLUE}1. ${WHITE}文件批量操作工具${NC}"
    echo "${BLUE}2. ${WHITE}系统备份和恢复${NC}"
    echo "${BLUE}3. ${WHITE}网络配置向导${NC}"
    echo "${BLUE}4. ${WHITE}用户管理工具${NC}"
    echo "${BLUE}5. ${WHITE}系统日志分析${NC}"
    echo "${BLUE}6. ${WHITE}系统性能调优${NC}"
    echo "${BLUE}7. ${WHITE}应用程序管理${NC}"
    echo "${BLUE}8. ${WHITE}远程连接管理${NC}"
    echo "${BLUE}9. ${WHITE}系统安全工具${NC}"
    echo "${BLUE}10. ${WHITE}环境变量管理${NC}"
    echo "${BLUE}11. ${WHITE}返回主菜单${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-11): ${NC}" choice
    
    case $choice in
        1)
            batch_file_operations
            show_main_menu
            ;;
        2)
            system_backup
            show_main_menu
            ;;
        3)
            network_config_wizard
            show_main_menu
            ;;
        4)
            user_management
            show_main_menu
            ;;
        5)
            system_log_analysis
            show_main_menu
            ;;
        6)
            system_performance
            show_main_menu
            ;;
        7)
            application_management
            show_main_menu
            ;;
        8)
            remote_connection
            show_main_menu
            ;;
        9)
            system_security
            show_main_menu
            ;;
        10)
            environment_variables
            show_main_menu
            ;;
        11)
            return
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            show_main_menu
            ;;
    esac
}

# 启动高级工具模块
show_main_menu