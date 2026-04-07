# Linux常用命令行介绍和使用指南

## 1. 文件和目录操作命令

### ls - 列出文件和目录
```bash
ls                    # 列出当前目录中的文件和目录
ls -l                 # 以长格式列出，显示详细信息
ls -a                 # 显示所有文件，包括隐藏文件
ls -la                # 显示所有文件的详细信息
ls -h                 # 以人性化的方式显示文件大小
ls -R                 # 递归列出子目录中的文件
```

### cd - 切换目录
```bash
cd /path/to/directory  # 切换到指定目录
cd ~                  # 切换到主目录
cd ..                 # 切换到上一级目录
cd -                  # 切换到上一个工作目录
```

### pwd - 显示当前目录
```bash
pwd                   # 显示当前工作目录的绝对路径
```

### mkdir - 创建目录
```bash
mkdir directory       # 创建单个目录
mkdir -p dir1/dir2    # 递归创建目录结构
mkdir -m 755 dir      # 创建目录并设置权限
```

### rmdir - 删除空目录
```bash
rmdir directory       # 删除空目录
rmdir -p dir1/dir2    # 递归删除空目录
```

### touch - 创建空文件
```bash
touch file.txt        # 创建空文件
```

### cp - 复制文件和目录
```bash
cp file1 file2        # 复制文件1到文件2
cp -r dir1 dir2       # 递归复制目录
cp -i file1 file2     # 复制前询问
cp -v file1 file2     # 显示复制过程
```

### mv - 移动/重命名文件和目录
```bash
mv file1 file2        # 重命名文件1为文件2
mv file /path/dir     # 移动文件到指定目录
mv -i file1 file2     # 移动前询问
```

### rm - 删除文件和目录
```bash
rm file               # 删除文件
rm -r directory       # 递归删除目录及其内容
rm -f file            # 强制删除，不提示
rm -rf directory      # 强制递归删除目录
```

### find - 查找文件和目录
```bash
find . -name "*.txt"   # 在当前目录及其子目录中查找.txt文件
find /path -type f    # 查找指定路径下的所有文件
find /path -size +1M  # 查找大于1MB的文件
find /path -mtime -7  # 查找7天内修改过的文件
```

### locate - 快速查找文件
```bash
locate file           # 快速查找文件（依赖于数据库）
updatedb              # 更新locate数据库
```

## 2. 文件内容操作命令

### cat - 查看文件内容
```bash
cat file.txt          # 查看文件内容
cat -n file.txt       # 查看文件内容并显示行号
cat file1 file2 > file3  # 合并文件1和文件2到文件3
```

### less - 分页查看文件内容
```bash
less file.txt         # 分页查看文件内容
```

### more - 逐页显示文件内容
```bash
more file.txt         # 逐页显示文件内容
```

### head - 查看文件开头
```bash
head file.txt         # 查看文件前10行
head -n 20 file.txt   # 查看文件前20行
```

### tail - 查看文件结尾
```bash
tail file.txt         # 查看文件后10行
tail -n 20 file.txt   # 查看文件后20行
tail -f file.txt      # 实时查看文件更新
```

### grep - 在文件中搜索文本
```bash
grep "pattern" file.txt  # 在文件中搜索模式
grep -i "pattern" file.txt  # 忽略大小写搜索
grep -r "pattern" directory  # 递归搜索目录
grep -n "pattern" file.txt  # 显示匹配行的行号
```

### sed - 文本替换工具
```bash
sed 's/old/new/' file.txt  # 替换每行第一个匹配
sed 's/old/new/g' file.txt  # 替换所有匹配
sed -i 's/old/new/g' file.txt  # 直接修改文件
```

### awk - 文本处理工具
```bash
awk '{print $1}' file.txt  # 打印每行第一个字段
awk -F"," '{print $2}' file.txt  # 使用逗号作为分隔符
```

## 3. 系统管理命令

### ps - 查看进程状态
```bash
ps                    # 查看当前用户的进程
ps aux                # 查看所有用户的进程
ps aux | grep process  # 查找特定进程
```

### top - 实时查看系统资源
```bash
top                   # 实时查看系统资源使用情况
```

### kill - 终止进程
```bash
kill PID              # 终止指定PID的进程
kill -9 PID           # 强制终止进程
```

### df - 查看磁盘使用情况
```bash
df                    # 查看磁盘使用情况
df -h                 # 以人性化方式显示
```

### du - 查看目录大小
```bash
du                    # 查看当前目录大小
du -h                 # 以人性化方式显示
du -sh directory      # 查看指定目录的总大小
```

### free - 查看内存使用情况
```bash
free                  # 查看内存使用情况
free -h               # 以人性化方式显示
```

### uname - 查看系统信息
```bash
uname -a              # 查看完整系统信息
uname -r              # 查看内核版本
```

### whoami - 显示当前用户
```bash
whoami                # 显示当前用户名
```

### id - 查看用户和组信息
```bash
id                    # 查看当前用户的ID和组信息
```

### passwd - 修改密码
```bash
passwd                # 修改当前用户的密码
passwd username       # 修改指定用户的密码
```

### sudo - 以管理员权限执行命令
```bash
sudo command          # 以管理员权限执行命令
```

## 4. 网络命令

### ping - 测试网络连接
```bash
ping google.com       # 测试与Google的连接
ping -c 4 google.com  # 发送4个ping包
```

### ifconfig - 查看网络接口信息
```bash
ifconfig              # 查看网络接口信息
```

### ip - 网络配置工具
```bash
ip addr               # 查看IP地址
ip route              # 查看路由表
```

### netstat - 查看网络状态
```bash
netstat -tuln         # 查看监听的端口
netstat -an           # 查看所有网络连接
```

### ss - 查看套接字状态
```bash
ss -tuln              # 查看监听的端口
```

### curl - 网络请求工具
```bash
curl https://example.com  # 发送HTTP请求
curl -O https://example.com/file  # 下载文件
```

### wget - 下载文件
```bash
wget https://example.com/file  # 下载文件
wget -c https://example.com/file  # 断点续传
```

### ssh - 远程登录
```bash
ssh user@hostname     # 远程登录到主机
```

### scp - 远程复制文件
```bash
scp file user@hostname:/path  # 复制文件到远程主机
scp user@hostname:/path/file .  # 从远程主机复制文件
```

## 5. 压缩和解压缩命令

### tar - 打包和压缩文件
```bash
tar -cvf archive.tar files/  # 打包文件
tar -xvf archive.tar         # 解包文件
tar -czvf archive.tar.gz files/  # 打包并压缩为gzip
tar -xzvf archive.tar.gz     # 解压缩gzip文件
tar -cjvf archive.tar.bz2 files/  # 打包并压缩为bzip2
tar -xjvf archive.tar.bz2     # 解压缩bzip2文件
```

### gzip - 压缩文件
```bash
gzip file.txt         # 压缩文件
gunzip file.txt.gz    # 解压缩文件
```

### zip - 压缩文件
```bash
zip archive.zip files/  # 压缩文件
unzip archive.zip      # 解压缩文件
```

## 6. 权限管理命令

### chmod - 修改文件权限
```bash
chmod 755 file        # 设置文件权限为755
chmod +x file         # 添加执行权限
chmod -w file         # 移除写权限
```

### chown - 修改文件所有者
```bash
chown user:group file  # 修改文件所有者和组
chown user file       # 修改文件所有者
chown :group file     # 修改文件组
```

### chgrp - 修改文件组
```bash
chgrp group file      # 修改文件组
```

## 7. 其他常用命令

### history - 查看命令历史
```bash
history               # 查看命令历史
history | grep command  # 搜索命令历史
```

### alias - 创建命令别名
```bash
alias ll='ls -la'     # 创建ll别名
unalias ll            # 移除别名
```

### export - 设置环境变量
```bash
export PATH=$PATH:/new/path  # 添加新路径到PATH
export VAR=value      # 设置环境变量
```

### echo - 输出文本
```bash
echo "Hello World"    # 输出文本
echo $VAR             # 输出环境变量
```

### date - 显示或设置系统时间
```bash
date                  # 显示当前时间
date +"%Y-%m-%d %H:%M:%S"  # 格式化显示时间
```

### cal - 显示日历
```bash
cal                   # 显示当前月份日历
cal 2023              # 显示2023年日历
```

### clear - 清屏
```bash
clear                 # 清屏
```

## 8. 命令行快捷键

| 快捷键 | 功能 |
|-------|------|
| Tab | 自动补全命令或路径 |
| Ctrl+C | 终止当前命令 |
| Ctrl+L | 清屏 |
| Ctrl+D | 退出终端 |
| ↑ ↓ | 浏览历史命令 |
| Ctrl+R | 搜索历史命令 |
| Ctrl+A | 移动到命令行开头 |
| Ctrl+E | 移动到命令行结尾 |
| Ctrl+U | 清除命令行内容 |
| Ctrl+K | 清除从光标到行尾的内容 |
| Ctrl+W | 清除光标前的单词 |

## 9. 命令行技巧

### 1. 使用通配符
```bash
ls *.txt              # 列出所有.txt文件
ls file[1-5].txt      # 列出file1.txt到file5.txt
ls file?.txt          # 列出file后跟着一个字符的.txt文件
```

### 2. 使用管道
```bash
ls -la | grep "file"  # 过滤ls结果，只显示包含"file"的行
ps aux | grep process  # 查找特定进程
```

### 3. 使用重定向
```bash
command > file        # 将命令输出重定向到文件（覆盖）
command >> file       # 将命令输出重定向到文件（追加）
command < file        # 从文件读取输入
command 2> error.log  # 将错误输出重定向到文件
command &> output.log  # 将所有输出重定向到文件
```

### 4. 使用命令组合
```bash
command1 && command2  # 只有command1成功执行后才执行command2
command1 || command2  # 只有command1执行失败后才执行command2
command1 ; command2   # 无论command1是否成功，都执行command2
```

### 5. 使用后台执行
```bash
command &             # 在后台执行命令
jobs                  # 查看后台任务
fg %1                 # 将后台任务1切换到前台
bg %1                 # 将前台任务1切换到后台
```

## 10. 故障排除

### 常见错误及解决方案

| 错误信息 | 可能原因 | 解决方案 |
|---------|---------|----------|
| Permission denied | 权限不足 | 使用sudo命令或修改文件权限 |
| No such file or directory | 文件或目录不存在 | 检查路径是否正确 |
| Command not found | 命令未安装或不在PATH中 | 安装命令或添加到PATH |
| Syntax error | 语法错误 | 检查命令语法 |
| Connection refused | 网络连接被拒绝 | 检查网络连接和服务状态 |

### 获取帮助

- `man 命令` - 查看命令的详细手册
- `命令 --help` - 查看命令的简要帮助
- `help 命令` - 查看内置命令的帮助
- `info 命令` - 查看命令的详细信息

## 总结

本指南涵盖了Linux命令行中最常用的命令及其用法。通过学习和实践这些命令，您将能够更高效地使用Linux系统。记住，命令行是Linux系统的强大工具，掌握它将使您的工作更加便捷和高效。

如果您需要更详细的信息，请参考各命令的手册页或在线文档。祝您在Linux命令行的世界中探索愉快！