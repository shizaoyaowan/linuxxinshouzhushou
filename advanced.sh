#!/bin/bash

# 高级功能扩展模块

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
    echo "${YELLOW}        Linux高级功能模块${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}高级功能扩展和专业领域工具${NC}"
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

# 容器管理工具
container_management() {
    show_title
    echo "${BLUE}容器管理工具${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}Docker管理${NC}"
    echo "${BLUE}2. ${WHITE}Kubernetes管理${NC}"
    echo "${BLUE}3. ${WHITE}返回上一级${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-3): ${NC}" choice
    
    case $choice in
        1)
            show_title
            echo "${BLUE}Docker管理${NC}"
            echo "${GREEN}=======================================${NC}"
            
            if command -v docker &> /dev/null; then
                echo "${BLUE}Docker版本:${NC}"
                docker --version
                echo "${GREEN}=======================================${NC}"
                echo "${BLUE}1. ${WHITE}查看容器${NC}"
                echo "${BLUE}2. ${WHITE}查看镜像${NC}"
                echo "${BLUE}3. ${WHITE}启动容器${NC}"
                echo "${BLUE}4. ${WHITE}停止容器${NC}"
                echo "${BLUE}5. ${WHITE}返回上一级${NC}"
                echo "${GREEN}=======================================${NC}"
                read -p "${YELLOW}请选择操作 (1-5): ${NC}" docker_choice
                
                case $docker_choice in
                    1)
                        echo "${YELLOW}正在查看容器...${NC}"
                        docker ps -a
                        read -p "${YELLOW}按Enter键返回...${NC}"
                        container_management
                        ;;
                    2)
                        echo "${YELLOW}正在查看镜像...${NC}"
                        docker images
                        read -p "${YELLOW}按Enter键返回...${NC}"
                        container_management
                        ;;
                    3)
                        read -p "${YELLOW}请输入容器名称或ID: ${NC}" container
                        echo "${YELLOW}正在启动容器...${NC}"
                        docker start "$container"
                        if [ $? -eq 0 ]; then
                            echo "${GREEN}容器启动成功！${NC}"
                        else
                            echo "${RED}容器启动失败！${NC}"
                        fi
                        read -p "${YELLOW}按Enter键返回...${NC}"
                        container_management
                        ;;
                    4)
                        read -p "${YELLOW}请输入容器名称或ID: ${NC}" container
                        echo "${YELLOW}正在停止容器...${NC}"
                        docker stop "$container"
                        if [ $? -eq 0 ]; then
                            echo "${GREEN}容器停止成功！${NC}"
                        else
                            echo "${RED}容器停止失败！${NC}"
                        fi
                        read -p "${YELLOW}按Enter键返回...${NC}"
                        container_management
                        ;;
                    5)
                        container_management
                        ;;
                    *)
                        echo "${RED}无效选择，请重新输入！${NC}"
                        sleep 2
                        container_management
                        ;;
                esac
            else
                echo "${RED}Docker未安装！${NC}"
                echo "${YELLOW}建议安装命令: ${WHITE}sudo apt install docker.io${NC}"
                read -p "${YELLOW}按Enter键返回...${NC}"
                container_management
            fi
            ;;
        2)
            show_title
            echo "${BLUE}Kubernetes管理${NC}"
            echo "${GREEN}=======================================${NC}"
            
            if command -v kubectl &> /dev/null; then
                echo "${BLUE}Kubernetes版本:${NC}"
                kubectl version --client
                echo "${GREEN}=======================================${NC}"
                echo "${BLUE}1. ${WHITE}查看节点${NC}"
                echo "${BLUE}2. ${WHITE}查看Pod${NC}"
                echo "${BLUE}3. ${WHITE}查看服务${NC}"
                echo "${BLUE}4. ${WHITE}返回上一级${NC}"
                echo "${GREEN}=======================================${NC}"
                read -p "${YELLOW}请选择操作 (1-4): ${NC}" k8s_choice
                
                case $k8s_choice in
                    1)
                        echo "${YELLOW}正在查看节点...${NC}"
                        kubectl get nodes
                        read -p "${YELLOW}按Enter键返回...${NC}"
                        container_management
                        ;;
                    2)
                        echo "${YELLOW}正在查看Pod...${NC}"
                        kubectl get pods --all-namespaces
                        read -p "${YELLOW}按Enter键返回...${NC}"
                        container_management
                        ;;
                    3)
                        echo "${YELLOW}正在查看服务...${NC}"
                        kubectl get services --all-namespaces
                        read -p "${YELLOW}按Enter键返回...${NC}"
                        container_management
                        ;;
                    4)
                        container_management
                        ;;
                    *)
                        echo "${RED}无效选择，请重新输入！${NC}"
                        sleep 2
                        container_management
                        ;;
                esac
            else
                echo "${RED}kubectl未安装！${NC}"
                echo "${YELLOW}建议安装命令: ${WHITE}sudo apt install kubectl${NC}"
                read -p "${YELLOW}按Enter键返回...${NC}"
                container_management
            fi
            ;;
        3)
            return
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            container_management
            ;;
    esac
}

# 云服务集成
cloud_services() {
    show_title
    echo "${BLUE}云服务集成${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}AWS管理${NC}"
    echo "${BLUE}2. ${WHITE}Azure管理${NC}"
    echo "${BLUE}3. ${WHITE}返回上一级${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-3): ${NC}" choice
    
    case $choice in
        1)
            show_title
            echo "${BLUE}AWS管理${NC}"
            echo "${GREEN}=======================================${NC}"
            
            if command -v aws &> /dev/null; then
                echo "${BLUE}AWS CLI版本:${NC}"
                aws --version
                echo "${GREEN}=======================================${NC}"
                echo "${BLUE}1. ${WHITE}查看S3存储桶${NC}"
                echo "${BLUE}2. ${WHITE}查看EC2实例${NC}"
                echo "${BLUE}3. ${WHITE}返回上一级${NC}"
                echo "${GREEN}=======================================${NC}"
                read -p "${YELLOW}请选择操作 (1-3): ${NC}" aws_choice
                
                case $aws_choice in
                    1)
                        echo "${YELLOW}正在查看S3存储桶...${NC}"
                        aws s3 ls
                        read -p "${YELLOW}按Enter键返回...${NC}"
                        cloud_services
                        ;;
                    2)
                        echo "${YELLOW}正在查看EC2实例...${NC}"
                        aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,State.Name,PublicIpAddress]' --output table
                        read -p "${YELLOW}按Enter键返回...${NC}"
                        cloud_services
                        ;;
                    3)
                        cloud_services
                        ;;
                    *)
                        echo "${RED}无效选择，请重新输入！${NC}"
                        sleep 2
                        cloud_services
                        ;;
                esac
            else
                echo "${RED}AWS CLI未安装！${NC}"
                echo "${YELLOW}建议安装命令: ${WHITE}pip install awscli${NC}"
                read -p "${YELLOW}按Enter键返回...${NC}"
                cloud_services
            fi
            ;;
        2)
            show_title
            echo "${BLUE}Azure管理${NC}"
            echo "${GREEN}=======================================${NC}"
            
            if command -v az &> /dev/null; then
                echo "${BLUE}Azure CLI版本:${NC}"
                az --version | head -1
                echo "${GREEN}=======================================${NC}"
                echo "${BLUE}1. ${WHITE}查看资源组${NC}"
                echo "${BLUE}2. ${WHITE}查看虚拟机${NC}"
                echo "${BLUE}3. ${WHITE}返回上一级${NC}"
                echo "${GREEN}=======================================${NC}"
                read -p "${YELLOW}请选择操作 (1-3): ${NC}" azure_choice
                
                case $azure_choice in
                    1)
                        echo "${YELLOW}正在查看资源组...${NC}"
                        az group list --output table
                        read -p "${YELLOW}按Enter键返回...${NC}"
                        cloud_services
                        ;;
                    2)
                        echo "${YELLOW}正在查看虚拟机...${NC}"
                        az vm list --output table
                        read -p "${YELLOW}按Enter键返回...${NC}"
                        cloud_services
                        ;;
                    3)
                        cloud_services
                        ;;
                    *)
                        echo "${RED}无效选择，请重新输入！${NC}"
                        sleep 2
                        cloud_services
                        ;;
                esac
            else
                echo "${RED}Azure CLI未安装！${NC}"
                echo "${YELLOW}建议安装命令: ${WHITE}curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash${NC}"
                read -p "${YELLOW}按Enter键返回...${NC}"
                cloud_services
            fi
            ;;
        3)
            return
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            cloud_services
            ;;
    esac
}

# 数据库管理
database_management() {
    show_title
    echo "${BLUE}数据库管理${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}MySQL管理${NC}"
    echo "${BLUE}2. ${WHITE}PostgreSQL管理${NC}"
    echo "${BLUE}3. ${WHITE}返回上一级${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-3): ${NC}" choice
    
    case $choice in
        1)
            show_title
            echo "${BLUE}MySQL管理${NC}"
            echo "${GREEN}=======================================${NC}"
            
            if command -v mysql &> /dev/null; then
                echo "${BLUE}MySQL客户端版本:${NC}"
                mysql --version
                echo "${GREEN}=======================================${NC}"
                echo "${BLUE}1. ${WHITE}连接数据库${NC}"
                echo "${BLUE}2. ${WHITE}查看数据库状态${NC}"
                echo "${BLUE}3. ${WHITE}返回上一级${NC}"
                echo "${GREEN}=======================================${NC}"
                read -p "${YELLOW}请选择操作 (1-3): ${NC}" mysql_choice
                
                case $mysql_choice in
                    1)
                        read -p "${YELLOW}请输入数据库用户: ${NC}" user
                        read -s -p "${YELLOW}请输入密码: ${NC}" password
                        echo
                        echo "${YELLOW}正在连接数据库...${NC}"
                        mysql -u "$user" -p"$password" -e "SHOW DATABASES;"
                        read -p "${YELLOW}按Enter键返回...${NC}"
                        database_management
                        ;;
                    2)
                        echo "${YELLOW}正在查看数据库状态...${NC}"
                        if command -v systemctl &> /dev/null; then
                            systemctl status mysql
                        else
                            service mysql status
                        fi
                        read -p "${YELLOW}按Enter键返回...${NC}"
                        database_management
                        ;;
                    3)
                        database_management
                        ;;
                    *)
                        echo "${RED}无效选择，请重新输入！${NC}"
                        sleep 2
                        database_management
                        ;;
                esac
            else
                echo "${RED}MySQL客户端未安装！${NC}"
                echo "${YELLOW}建议安装命令: ${WHITE}sudo apt install mysql-client${NC}"
                read -p "${YELLOW}按Enter键返回...${NC}"
                database_management
            fi
            ;;
        2)
            show_title
            echo "${BLUE}PostgreSQL管理${NC}"
            echo "${GREEN}=======================================${NC}"
            
            if command -v psql &> /dev/null; then
                echo "${BLUE}PostgreSQL客户端版本:${NC}"
                psql --version
                echo "${GREEN}=======================================${NC}"
                echo "${BLUE}1. ${WHITE}连接数据库${NC}"
                echo "${BLUE}2. ${WHITE}查看数据库状态${NC}"
                echo "${BLUE}3. ${WHITE}返回上一级${NC}"
                echo "${GREEN}=======================================${NC}"
                read -p "${YELLOW}请选择操作 (1-3): ${NC}" psql_choice
                
                case $psql_choice in
                    1)
                        read -p "${YELLOW}请输入数据库用户: ${NC}" user
                        read -s -p "${YELLOW}请输入密码: ${NC}" password
                        echo
                        echo "${YELLOW}正在连接数据库...${NC}"
                        PGPASSWORD="$password" psql -U "$user" -c "\l"
                        read -p "${YELLOW}按Enter键返回...${NC}"
                        database_management
                        ;;
                    2)
                        echo "${YELLOW}正在查看数据库状态...${NC}"
                        if command -v systemctl &> /dev/null; then
                            systemctl status postgresql
                        else
                            service postgresql status
                        fi
                        read -p "${YELLOW}按Enter键返回...${NC}"
                        database_management
                        ;;
                    3)
                        database_management
                        ;;
                    *)
                        echo "${RED}无效选择，请重新输入！${NC}"
                        sleep 2
                        database_management
                        ;;
                esac
            else
                echo "${RED}PostgreSQL客户端未安装！${NC}"
                echo "${YELLOW}建议安装命令: ${WHITE}sudo apt install postgresql-client${NC}"
                read -p "${YELLOW}按Enter键返回...${NC}"
                database_management
            fi
            ;;
        3)
            return
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            database_management
            ;;
    esac
}

# 版本控制
git_management() {
    show_title
    echo "${BLUE}版本控制 (Git)${NC}"
    echo "${GREEN}=======================================${NC}"
    
    if command -v git &> /dev/null; then
        echo "${BLUE}Git版本:${NC}"
        git --version
        echo "${GREEN}=======================================${NC}"
        echo "${BLUE}1. ${WHITE}初始化仓库${NC}"
        echo "${BLUE}2. ${WHITE}查看状态${NC}"
        echo "${BLUE}3. ${WHITE}添加文件${NC}"
        echo "${BLUE}4. ${WHITE}提交更改${NC}"
        echo "${BLUE}5. ${WHITE}查看历史${NC}"
        echo "${BLUE}6. ${WHITE}返回上一级${NC}"
        echo "${GREEN}=======================================${NC}"
        read -p "${YELLOW}请选择操作 (1-6): ${NC}" choice
        
        case $choice in
            1)
                read -p "${YELLOW}请输入仓库名称: ${NC}" repo_name
                echo "${YELLOW}正在初始化仓库...${NC}"
                mkdir -p "$repo_name"
                cd "$repo_name"
                git init
                cd ..
                echo "${GREEN}仓库初始化成功！${NC}"
                read -p "${YELLOW}按Enter键返回...${NC}"
                git_management
                ;;
            2)
                echo "${YELLOW}正在查看状态...${NC}"
                git status
                read -p "${YELLOW}按Enter键返回...${NC}"
                git_management
                ;;
            3)
                read -p "${YELLOW}请输入要添加的文件: ${NC}" file
                echo "${YELLOW}正在添加文件...${NC}"
                git add "$file"
                echo "${GREEN}文件添加成功！${NC}"
                read -p "${YELLOW}按Enter键返回...${NC}"
                git_management
                ;;
            4)
                read -p "${YELLOW}请输入提交信息: ${NC}" message
                echo "${YELLOW}正在提交更改...${NC}"
                git commit -m "$message"
                echo "${GREEN}提交成功！${NC}"
                read -p "${YELLOW}按Enter键返回...${NC}"
                git_management
                ;;
            5)
                echo "${YELLOW}正在查看历史...${NC}"
                git log --oneline
                read -p "${YELLOW}按Enter键返回...${NC}"
                git_management
                ;;
            6)
                return
                ;;
            *)
                echo "${RED}无效选择，请重新输入！${NC}"
                sleep 2
                git_management
                ;;
        esac
    else
        echo "${RED}Git未安装！${NC}"
        echo "${YELLOW}建议安装命令: ${WHITE}sudo apt install git${NC}"
        read -p "${YELLOW}按Enter键返回...${NC}"
        return
    fi
}

# 远程管理
remote_management() {
    show_title
    echo "${BLUE}远程管理${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}SSH配置${NC}"
    echo "${BLUE}2. ${WHITE}远程桌面配置${NC}"
    echo "${BLUE}3. ${WHITE}返回上一级${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-3): ${NC}" choice
    
    case $choice in
        1)
            show_title
            echo "${BLUE}SSH配置${NC}"
            echo "${GREEN}=======================================${NC}"
            
            if command -v ssh &> /dev/null; then
                echo "${BLUE}SSH版本:${NC}"
                ssh -V
                echo "${GREEN}=======================================${NC}"
                echo "${BLUE}1. ${WHITE}生成SSH密钥${NC}"
                echo "${BLUE}2. ${WHITE}查看SSH配置${NC}"
                echo "${BLUE}3. ${WHITE}连接远程主机${NC}"
                echo "${BLUE}4. ${WHITE}返回上一级${NC}"
                echo "${GREEN}=======================================${NC}"
                read -p "${YELLOW}请选择操作 (1-4): ${NC}" ssh_choice
                
                case $ssh_choice in
                    1)
                        echo "${YELLOW}正在生成SSH密钥...${NC}"
                        ssh-keygen -t rsa -b 4096
                        echo "${GREEN}SSH密钥生成成功！${NC}"
                        read -p "${YELLOW}按Enter键返回...${NC}"
                        remote_management
                        ;;
                    2)
                        echo "${YELLOW}正在查看SSH配置...${NC}"
                        if [ -f "~/.ssh/config" ]; then
                            cat ~/.ssh/config
                        else
                            echo "${YELLOW}SSH配置文件不存在${NC}"
                        fi
                        read -p "${YELLOW}按Enter键返回...${NC}"
                        remote_management
                        ;;
                    3)
                        read -p "${YELLOW}请输入远程主机IP: ${NC}" host
                        read -p "${YELLOW}请输入用户名: ${NC}" user
                        echo "${YELLOW}正在连接远程主机...${NC}"
                        echo "${WHITE}命令: ssh $user@$host${NC}"
                        read -p "${YELLOW}按Enter键返回...${NC}"
                        remote_management
                        ;;
                    4)
                        remote_management
                        ;;
                    *)
                        echo "${RED}无效选择，请重新输入！${NC}"
                        sleep 2
                        remote_management
                        ;;
                esac
            else
                echo "${RED}SSH未安装！${NC}"
                echo "${YELLOW}建议安装命令: ${WHITE}sudo apt install openssh-client${NC}"
                read -p "${YELLOW}按Enter键返回...${NC}"
                remote_management
            fi
            ;;
        2)
            show_title
            echo "${BLUE}远程桌面配置${NC}"
            echo "${GREEN}=======================================${NC}"
            
            echo "${BLUE}VNC服务器配置:${NC}"
            echo "1. 安装VNC服务器: sudo apt install tightvncserver"
            echo "2. 启动VNC服务器: vncserver"
            echo "3. 连接VNC服务器: 使用VNC客户端连接 IP:5901"
            echo "${GREEN}=======================================${NC}"
            echo "${BLUE}XRDP配置:${NC}"
            echo "1. 安装XRDP: sudo apt install xrdp"
            echo "2. 启动XRDP服务: sudo systemctl start xrdp"
            echo "3. 连接XRDP: 使用远程桌面客户端连接 IP"
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            remote_management
            ;;
        3)
            return
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            remote_management
            ;;
    esac
}

# 安全工具
security_tools() {
    show_title
    echo "${BLUE}安全工具${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}入侵检测${NC}"
    echo "${BLUE}2. ${WHITE}漏洞扫描${NC}"
    echo "${BLUE}3. ${WHITE}防火墙配置${NC}"
    echo "${BLUE}4. ${WHITE}返回上一级${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-4): ${NC}" choice
    
    case $choice in
        1)
            show_title
            echo "${BLUE}入侵检测${NC}"
            echo "${GREEN}=======================================${NC}"
            
            if command -v fail2ban &> /dev/null; then
                echo "${BLUE}Fail2ban状态:${NC}"
                if command -v systemctl &> /dev/null; then
                    systemctl status fail2ban
                else
                    service fail2ban status
                fi
            else
                echo "${YELLOW}Fail2ban未安装${NC}"
                echo "${YELLOW}建议安装命令: ${WHITE}sudo apt install fail2ban${NC}"
            fi
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            security_tools
            ;;
        2)
            show_title
            echo "${BLUE}漏洞扫描${NC}"
            echo "${GREEN}=======================================${NC}"
            
            if command -v nmap &> /dev/null; then
                echo "${BLUE}Nmap版本:${NC}"
                nmap --version | head -1
                read -p "${YELLOW}请输入要扫描的IP地址: ${NC}" ip
                echo "${YELLOW}正在扫描...${NC}"
                nmap -sV "$ip"
            else
                echo "${YELLOW}Nmap未安装${NC}"
                echo "${YELLOW}建议安装命令: ${WHITE}sudo apt install nmap${NC}"
            fi
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            security_tools
            ;;
        3)
            show_title
            echo "${BLUE}防火墙配置${NC}"
            echo "${GREEN}=======================================${NC}"
            
            if command -v ufw &> /dev/null; then
                echo "${BLUE}UFW状态:${NC}"
                sudo ufw status
                echo "${GREEN}=======================================${NC}"
                echo "${YELLOW}常用UFW命令:${NC}"
                echo "- sudo ufw enable - 启用防火墙"
                echo "- sudo ufw disable - 禁用防火墙"
                echo "- sudo ufw allow 22 - 允许SSH端口"
                echo "- sudo ufw deny 80 - 拒绝HTTP端口"
            elif command -v iptables &> /dev/null; then
                echo "${BLUE}Iptables规则:${NC}"
                sudo iptables -L
            else
                echo "${YELLOW}防火墙工具未安装${NC}"
            fi
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            security_tools
            ;;
        4)
            return
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            security_tools
            ;;
    esac
}

# 开发工具
development_tools() {
    show_title
    echo "${BLUE}开发工具${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}代码编辑器${NC}"
    echo "${BLUE}2. ${WHITE}构建工具${NC}"
    echo "${BLUE}3. ${WHITE}包管理器${NC}"
    echo "${BLUE}4. ${WHITE}返回上一级${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-4): ${NC}" choice
    
    case $choice in
        1)
            show_title
            echo "${BLUE}代码编辑器${NC}"
            echo "${GREEN}=======================================${NC}"
            
            echo "${YELLOW}常用代码编辑器:${NC}"
            echo "1. Visual Studio Code - sudo apt install code"
            echo "2. Vim - sudo apt install vim"
            echo "3. Nano - 通常已默认安装"
            echo "4. Emacs - sudo apt install emacs"
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            development_tools
            ;;
        2)
            show_title
            echo "${BLUE}构建工具${NC}"
            echo "${GREEN}=======================================${NC}"
            
            echo "${YELLOW}常用构建工具:${NC}"
            echo "1. Make - sudo apt install make"
            echo "2. CMake - sudo apt install cmake"
            echo "3. Gradle - sudo apt install gradle"
            echo "4. Maven - sudo apt install maven"
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            development_tools
            ;;
        3)
            show_title
            echo "${BLUE}包管理器${NC}"
            echo "${GREEN}=======================================${NC}"
            
            echo "${YELLOW}常用包管理器:${NC}"
            echo "1. npm (Node.js) - sudo apt install npm"
            echo "2. pip (Python) - sudo apt install python3-pip"
            echo "3. cargo (Rust) - curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
            echo "4. composer (PHP) - sudo apt install composer"
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            development_tools
            ;;
        4)
            return
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            development_tools
            ;;
    esac
}

# 多媒体工具
multimedia_tools() {
    show_title
    echo "${BLUE}多媒体工具${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}音频处理${NC}"
    echo "${BLUE}2. ${WHITE}视频处理${NC}"
    echo "${BLUE}3. ${WHITE}图像编辑${NC}"
    echo "${BLUE}4. ${WHITE}返回上一级${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-4): ${NC}" choice
    
    case $choice in
        1)
            show_title
            echo "${BLUE}音频处理${NC}"
            echo "${GREEN}=======================================${NC}"
            
            echo "${YELLOW}常用音频处理工具:${NC}"
            echo "1. Audacity - sudo apt install audacity"
            echo "2. FFmpeg - sudo apt install ffmpeg"
            echo "3. SoX - sudo apt install sox"
            echo "4. Alsamixer - 通常已默认安装"
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            multimedia_tools
            ;;
        2)
            show_title
            echo "${BLUE}视频处理${NC}"
            echo "${GREEN}=======================================${NC}"
            
            echo "${YELLOW}常用视频处理工具:${NC}"
            echo "1. FFmpeg - sudo apt install ffmpeg"
            echo "2. HandBrake - sudo apt install handbrake"
            echo "3. OpenShot - sudo apt install openshot"
            echo "4. VLC - sudo apt install vlc"
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            multimedia_tools
            ;;
        3)
            show_title
            echo "${BLUE}图像编辑${NC}"
            echo "${GREEN}=======================================${NC}"
            
            echo "${YELLOW}常用图像编辑工具:${NC}"
            echo "1. GIMP - sudo apt install gimp"
            echo "2. Inkscape - sudo apt install inkscape"
            echo "3. ImageMagick - sudo apt install imagemagick"
            echo "4. Shotwell - sudo apt install shotwell"
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            multimedia_tools
            ;;
        4)
            return
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            multimedia_tools
            ;;
    esac
}

# 网络工具
network_tools() {
    show_title
    echo "${BLUE}网络工具${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}端口转发${NC}"
    echo "${BLUE}2. ${WHITE}VPN配置${NC}"
    echo "${BLUE}3. ${WHITE}网络诊断${NC}"
    echo "${BLUE}4. ${WHITE}返回上一级${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-4): ${NC}" choice
    
    case $choice in
        1)
            show_title
            echo "${BLUE}端口转发${NC}"
            echo "${GREEN}=======================================${NC}"
            
            echo "${YELLOW}使用SSH进行端口转发:${NC}"
            echo "1. 本地端口转发: ssh -L 本地端口:目标IP:目标端口 用户@服务器"
            echo "2. 远程端口转发: ssh -R 远程端口:本地IP:本地端口 用户@服务器"
            echo "3. 动态端口转发: ssh -D 本地端口 用户@服务器"
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            network_tools
            ;;
        2)
            show_title
            echo "${BLUE}VPN配置${NC}"
            echo "${GREEN}=======================================${NC}"
            
            echo "${YELLOW}常用VPN解决方案:${NC}"
            echo "1. OpenVPN - sudo apt install openvpn"
            echo "2. WireGuard - sudo apt install wireguard"
            echo "3. PPTP - sudo apt install pptp-linux"
            echo "4. L2TP - sudo apt install xl2tpd"
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            network_tools
            ;;
        3)
            show_title
            echo "${BLUE}网络诊断${NC}"
            echo "${GREEN}=======================================${NC}"
            
            echo "${YELLOW}常用网络诊断命令:${NC}"
            echo "1. ping - 测试网络连接"
            echo "2. traceroute - 跟踪网络路径"
            echo "3. netstat - 查看网络状态"
            echo "4. ss - 查看网络连接"
            echo "5. dig - DNS查询"
            echo "6. nslookup - DNS查询"
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            network_tools
            ;;
        4)
            return
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            network_tools
            ;;
    esac
}

# 存储管理
storage_management() {
    show_title
    echo "${BLUE}存储管理${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}LVM配置${NC}"
    echo "${BLUE}2. ${WHITE}RAID管理${NC}"
    echo "${BLUE}3. ${WHITE}磁盘分区${NC}"
    echo "${BLUE}4. ${WHITE}返回上一级${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-4): ${NC}" choice
    
    case $choice in
        1)
            show_title
            echo "${BLUE}LVM配置${NC}"
            echo "${GREEN}=======================================${NC}"
            
            if command -v lvdisplay &> /dev/null; then
                echo "${YELLOW}LVM卷组:${NC}"
                sudo vgdisplay
                echo "${GREEN}=======================================${NC}"
                echo "${YELLOW}LVM逻辑卷:${NC}"
                sudo lvdisplay
            else
                echo "${YELLOW}LVM工具未安装${NC}"
                echo "${YELLOW}建议安装命令: ${WHITE}sudo apt install lvm2${NC}"
            fi
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            storage_management
            ;;
        2)
            show_title
            echo "${BLUE}RAID管理${NC}"
            echo "${GREEN}=======================================${NC}"
            
            if command -v mdadm &> /dev/null; then
                echo "${YELLOW}RAID阵列:${NC}"
                sudo mdadm --detail --scan
            else
                echo "${YELLOW}mdadm工具未安装${NC}"
                echo "${YELLOW}建议安装命令: ${WHITE}sudo apt install mdadm${NC}"
            fi
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            storage_management
            ;;
        3)
            show_title
            echo "${BLUE}磁盘分区${NC}"
            echo "${GREEN}=======================================${NC}"
            
            echo "${YELLOW}磁盘信息:${NC}"
            sudo fdisk -l
            echo "${GREEN}=======================================${NC}"
            echo "${YELLOW}常用分区命令:${NC}"
            echo "1. fdisk - 传统分区工具"
            echo "2. parted - 高级分区工具"
            echo "3. gdisk - GPT分区工具"
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            storage_management
            ;;
        4)
            return
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            storage_management
            ;;
    esac
}

# 用户体验改进
user_experience() {
    show_title
    echo "${BLUE}用户体验改进${NC}"
    echo "${GREEN}=======================================${NC}"
    echo "${BLUE}1. ${WHITE}界面定制${NC}"
    echo "${BLUE}2. ${WHITE}智能命令建议${NC}"
    echo "${BLUE}3. ${WHITE}详细帮助信息${NC}"
    echo "${BLUE}4. ${WHITE}图形界面支持${NC}"
    echo "${BLUE}5. ${WHITE}返回上一级${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-5): ${NC}" choice
    
    case $choice in
        1)
            show_title
            echo "${BLUE}界面定制${NC}"
            echo "${GREEN}=======================================${NC}"
            
            echo "${YELLOW}界面定制选项:${NC}"
            echo "1. 颜色主题 - 已在用户配置中提供"
            echo "2. 提示符定制 - 编辑 ~/.bashrc 文件"
            echo "3. 终端字体 - 在终端设置中配置"
            echo "4. 终端背景 - 在终端设置中配置"
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            user_experience
            ;;
        2)
            show_title
            echo "${BLUE}智能命令建议${NC}"
            echo "${GREEN}=======================================${NC}"
            
            echo "${YELLOW}智能命令建议工具:${NC}"
            echo "1. bash-completion - 命令自动补全"
            echo "2. fish shell - 智能命令建议"
            echo "3. zsh + oh-my-zsh - 高级命令补全"
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            user_experience
            ;;
        3)
            show_title
            echo "${BLUE}详细帮助信息${NC}"
            echo "${GREEN}=======================================${NC}"
            
            echo "${YELLOW}帮助信息获取方式:${NC}"
            echo "1. 命令 --help - 查看命令帮助"
            echo "2. man 命令 - 查看手册页"
            echo "3. info 命令 - 查看详细信息"
            echo "4. tldr 命令 - 查看简化帮助 (需要安装)"
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            user_experience
            ;;
        4)
            show_title
            echo "${BLUE}图形界面支持${NC}"
            echo "${GREEN}=======================================${NC}"
            
            echo "${YELLOW}图形界面安装:${NC}"
            echo "1. GNOME - sudo apt install ubuntu-desktop"
            echo "2. KDE - sudo apt install kubuntu-desktop"
            echo "3. XFCE - sudo apt install xubuntu-desktop"
            echo "4. LXDE - sudo apt install lubuntu-desktop"
            
            read -p "${YELLOW}按Enter键返回...${NC}"
            user_experience
            ;;
        5)
            return
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            user_experience
            ;;
    esac
}

# 主菜单
show_main_menu() {
    show_title
    echo "${BLUE}1. ${WHITE}高级功能扩展${NC}"
    echo "${BLUE}2. ${WHITE}专业领域工具${NC}"
    echo "${BLUE}3. ${WHITE}用户体验改进${NC}"
    echo "${BLUE}4. ${WHITE}返回主菜单${NC}"
    echo "${GREEN}=======================================${NC}"
    read -p "${YELLOW}请选择操作 (1-4): ${NC}" choice
    
    case $choice in
        1)
            show_title
            echo "${BLUE}高级功能扩展${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${BLUE}1. ${WHITE}容器管理${NC}"
            echo "${BLUE}2. ${WHITE}云服务集成${NC}"
            echo "${BLUE}3. ${WHITE}数据库管理${NC}"
            echo "${BLUE}4. ${WHITE}版本控制${NC}"
            echo "${BLUE}5. ${WHITE}远程管理${NC}"
            echo "${BLUE}6. ${WHITE}返回上一级${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请选择操作 (1-6): ${NC}" advanced_choice
            
            case $advanced_choice in
                1)
                    container_management
                    show_main_menu
                    ;;
                2)
                    cloud_services
                    show_main_menu
                    ;;
                3)
                    database_management
                    show_main_menu
                    ;;
                4)
                    git_management
                    show_main_menu
                    ;;
                5)
                    remote_management
                    show_main_menu
                    ;;
                6)
                    show_main_menu
                    ;;
                *)
                    echo "${RED}无效选择，请重新输入！${NC}"
                    sleep 2
                    show_main_menu
                    ;;
            esac
            ;;
        2)
            show_title
            echo "${BLUE}专业领域工具${NC}"
            echo "${GREEN}=======================================${NC}"
            echo "${BLUE}1. ${WHITE}安全工具${NC}"
            echo "${BLUE}2. ${WHITE}开发工具${NC}"
            echo "${BLUE}3. ${WHITE}多媒体工具${NC}"
            echo "${BLUE}4. ${WHITE}网络工具${NC}"
            echo "${BLUE}5. ${WHITE}存储管理${NC}"
            echo "${BLUE}6. ${WHITE}返回上一级${NC}"
            echo "${GREEN}=======================================${NC}"
            read -p "${YELLOW}请选择操作 (1-6): ${NC}" professional_choice
            
            case $professional_choice in
                1)
                    security_tools
                    show_main_menu
                    ;;
                2)
                    development_tools
                    show_main_menu
                    ;;
                3)
                    multimedia_tools
                    show_main_menu
                    ;;
                4)
                    network_tools
                    show_main_menu
                    ;;
                5)
                    storage_management
                    show_main_menu
                    ;;
                6)
                    show_main_menu
                    ;;
                *)
                    echo "${RED}无效选择，请重新输入！${NC}"
                    sleep 2
                    show_main_menu
                    ;;
            esac
            ;;
        3)
            user_experience
            show_main_menu
            ;;
        4)
            return
            ;;
        *)
            echo "${RED}无效选择，请重新输入！${NC}"
            sleep 2
            show_main_menu
            ;;
    esac
}

# 启动高级功能模块
show_main_menu