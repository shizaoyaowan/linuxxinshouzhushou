# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
NC='\033[0m' # No Color

# 定制提示符
export PS1="${GREEN}\u${NC}@${BLUE}\h${NC}:${YELLOW}\w${NC}\$ "

# 命令别名
alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -a'
alias l='ls -CF'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# 系统信息命令
alias df='df -h'
alias du='du -h'
alias free='free -h'

# 快捷命令
alias cls='clear'
alias c='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# 安全相关
alias chmod='chmod --preserve-root'
alias chown='chown --preserve-root'

# 历史命令增强
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTCONTROL=ignoreboth
export HISTIGNORE="ls:cd:pwd:exit:clear"

# 自动补全增强
source /etc/bash_completion 2>/dev/null

# 时间显示
export TZ='Asia/Shanghai'

# 编辑器设置
export EDITOR='nano'

# 路径设置
export PATH=$PATH:$HOME/bin

# 系统工具命令
alias helpme='bash f:\\linuxminglinghang\\helpme.sh'
alias sysmonitor='bash f:\\linuxminglinghang\\sysmonitor.sh'
alias filemanager='bash f:\\linuxminglinghang\\filemanager.sh'
alias linux助手='bash f:\\linuxminglinghang\\linux新手开荒助手.sh'

# 欢迎信息
echo "${GREEN}欢迎使用增强版Linux命令行！${NC}"
echo "${YELLOW}输入 'helpme' 查看使用指南${NC}"
echo "${YELLOW}输入 'sysmonitor' 查看系统状态${NC}"
echo "${YELLOW}输入 'filemanager' 管理文件${NC}"
echo "${YELLOW}输入 'linux助手' 启动傻瓜式操作工具${NC}"
echo