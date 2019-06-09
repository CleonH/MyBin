### 把zsh设为默认shell
chsh -s $(which zsh)


- 欢迎来到小码哥的博客 博客搬家啦 blog.ma6174.com
```
#color{{{
autoload colors
colors
 
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
eval _$color='%{$terminfo[bold]$fg[${(L)color}]%}'
eval $color='%{$fg[${(L)color}]%}'
(( count = $count + 1 ))
done
FINISH="%{$terminfo[sgr0]%}"
#}}}
 
#命令提示符
RPROMPT=$(echo "$RED%D %T$FINISH")
PROMPT=$(echo "$CYAN%n@$YELLOW%M:$GREEN%/$_YELLOW>$FINISH ")
 
#PROMPT=$(echo "$BLUE%M$GREEN%/
#$CYAN%n@$BLUE%M:$GREEN%/$_YELLOW>>>$FINISH ")
#标题栏、任务栏样式{{{
case $TERM in (*xterm*|*rxvt*|(dt|k|E)term)
precmd () { print -Pn "\e]0;%n@%M//%/\a" }
preexec () { print -Pn "\e]0;%n@%M//%/\ $1\a" }
;;
esac
#}}}
 
#编辑器
export EDITOR=vim
#输入法
export XMODIFIERS="@im=ibus"
export QT_MODULE=ibus
export GTK_MODULE=ibus
#关于历史纪录的配置 {{{
#历史纪录条目数量
export HISTSIZE=10000
#注销后保存的历史纪录条目数量
export SAVEHIST=10000
#历史纪录文件
export HISTFILE=~/.zhistory
#以附加的方式写入历史纪录
setopt INC_APPEND_HISTORY
#如果连续输入的命令相同，历史纪录中只保留一个
setopt HIST_IGNORE_DUPS
#为历史纪录中的命令添加时间戳
setopt EXTENDED_HISTORY      
 
#启用 cd 命令的历史纪录，cd -[TAB]进入历史路径
setopt AUTO_PUSHD
#相同的历史路径只保留一个
setopt PUSHD_IGNORE_DUPS
 
#在命令前添加空格，不将此命令添加到纪录文件中
#setopt HIST_IGNORE_SPACE
#}}}
 
#每个目录使用独立的历史纪录{{{
cd() {
builtin cd "$@"                             # do actual cd
fc -W                                       # write current history  file
local HISTDIR="$HOME/.zsh_history$PWD"      # use nested folders for history
if  [ ! -d "$HISTDIR" ] ; then          # create folder if needed
mkdir -p "$HISTDIR"
fi
export HISTFILE="$HISTDIR/zhistory"     # set new history file
touch $HISTFILE
local ohistsize=$HISTSIZE
HISTSIZE=0                              # Discard previous dir's history
HISTSIZE=$ohistsize                     # Prepare for new dir's history
fc -R                                       #read from current histfile
}
mkdir -p $HOME/.zsh_history$PWD
export HISTFILE="$HOME/.zsh_history$PWD/zhistory"
 
function allhistory { cat $(find $HOME/.zsh_history -name zhistory) }
function convhistory {
sort $1 | uniq |
sed 's/^:\([ 0-9]*\):[0-9]*;\(.*\)/\1::::::\2/' |
awk -F"::::::" '{ $1=strftime("%Y-%m-%d %T",$1) "|"; print }'
}
#使用 histall 命令查看全部历史纪录
function histall { convhistory =(allhistory) |
sed '/^.\{20\} *cd/i\\' }
#使用 hist 查看当前目录历史纪录
function hist { convhistory $HISTFILE }
 
#全部历史纪录 top50
function top50 { allhistory | awk -F':[ 0-9]*:[0-9]*;' '{ $1="" ; print }' | sed 's/ /\n/g' | sed '/^$/d' | sort | uniq -c | sort -nr | head -n 50 }
 
#}}}
 
#杂项 {{{
#允许在交互模式中使用注释  例如：
#cmd #这是注释
setopt INTERACTIVE_COMMENTS      
 
#启用自动 cd，输入目录名回车进入目录
#稍微有点混乱，不如 cd 补全实用
setopt AUTO_CD
 
#扩展路径
#/v/c/p/p => /var/cache/pacman/pkg
setopt complete_in_word
 
#禁用 core dumps
limit coredumpsize 0
 
#Emacs风格 键绑定
bindkey -e
#bindkey -v
#设置 [DEL]键 为向后删除
#bindkey "\e[3~" delete-char
 
#以下字符视为单词的一部分
WORDCHARS='*?_-[]~=&;!#$%^(){}<>'
#}}}
 
#自动补全功能 {{{
setopt AUTO_LIST
setopt AUTO_MENU
#开启此选项，补全时会直接选中菜单项
#setopt MENU_COMPLETE
 
autoload -U compinit
compinit
 
#自动补全缓存
#zstyle ':completion::complete:*' use-cache on
#zstyle ':completion::complete:*' cache-path .zcache
#zstyle ':completion:*:cd:*' ignore-parents parent pwd
 
#自动补全选项
zstyle ':completion:*' verbose yes
zstyle ':completion:*' menu select
zstyle ':completion:*:*:default' force-list always
zstyle ':completion:*' select-prompt '%SSelect:  lines: %L  matches: %M  [%p]'
 
zstyle ':completion:*:match:*' original only
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate
 
#路径补全
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-shlashes 'yes'
zstyle ':completion::complete:*' '\\'
 
#彩色补全菜单
eval $(dircolors -b)
export ZLSCOLORS="${LS_COLORS}"
zmodload zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
 
#修正大小写
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
#错误校正
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
 
#kill 命令补全
compdef pkill=kill
compdef pkill=killall
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:processes' command 'ps -au$USER'
 
#补全类型提示分组
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m'
zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'
zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'
zstyle ':completion:*:corrections' format $'\e[01;32m -- %d (errors: %e) --\e[0m'
 
# cd ~ 补全顺序
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
#}}}
 
##行编辑高亮模式 {{{
# Ctrl+@ 设置标记，标记和光标点之间为 region
zle_highlight=(region:bg=magenta #选中区域
special:bold      #特殊字符
isearch:underline)#搜索时使用的关键字
#}}}
 
##空行(光标在行首)补全 "cd " {{{
user-complete(){
case $BUFFER in
"" )                       # 空行填入 "cd "
BUFFER="cd "
zle end-of-line
zle expand-or-complete
;;
"cd --" )                  # "cd --" 替换为 "cd +"
BUFFER="cd +"
zle end-of-line
zle expand-or-complete
;;
"cd +-" )                  # "cd +-" 替换为 "cd -"
BUFFER="cd -"
zle end-of-line
zle expand-or-complete
;;
* )
zle expand-or-complete
;;
esac
}
zle -N user-complete
bindkey "\t" user-complete
#}}}
 
##在命令前插入 sudo {{{
#定义功能
sudo-command-line() {
[[ -z $BUFFER ]] && zle up-history
[[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
zle end-of-line                 #光标移动到行末
}
zle -N sudo-command-line
#定义快捷键为： [Esc] [Esc]
bindkey "\e\e" sudo-command-line
#}}}
 
#命令别名 {{{
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias ls='ls -F --color=auto'
alias ll='ls -al'
alias grep='grep --color=auto'
alias la='ls -a'
alias pacman='sudo pacman-color'
alias p='sudo pacman-color'
alias y='yaourt'
alias h='htop'
alias vim='sudo vim'
 
#[Esc][h] man 当前命令时，显示简短说明
alias run-help >&/dev/null && unalias run-help
autoload run-help
 
#历史命令 top10
alias top10='print -l  ${(o)history%% *} | uniq -c | sort -nr | head -n 10'
#}}}
 
#路径别名 {{{
#进入相应的路径时只要 cd ~xxx
hash -d A="/media/ayu/dearest"
hash -d H="/media/data/backup/ayu"
hash -d E="/etc/"
hash -d D="/home/ayumi/Documents"
#}}}
 
##for Emacs {{{
#在 Emacs终端 中使用 Zsh 的一些设置 不推荐在 Emacs 中使用它
#if [[ "$TERM" == "dumb" ]]; then
#setopt No_zle
#PROMPT='%n@%M %/
#>>'
#alias ls='ls -F'
#fi
#}}}
 
#{{{自定义补全
#补全 ping
zstyle ':completion:*:ping:*' hosts 192.168.1.{1,50,51,100,101} www.google.com
 
#补全 ssh scp sftp 等
#zstyle -e ':completion::*:*:*:hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'
#}}}
 
#{{{ F1 计算器
arith-eval-echo() {
LBUFFER="${LBUFFER}echo \$(( "
RBUFFER=" ))$RBUFFER"
}
zle -N arith-eval-echo
bindkey "^[[11~" arith-eval-echo
#}}}
 
####{{{
function timeconv { date -d @$1 +"%Y-%m-%d %T" }
 
# }}}
 
zmodload zsh/mathfunc
autoload -U zsh-mime-setup
zsh-mime-setup
setopt EXTENDED_GLOB
#autoload -U promptinit
#promptinit
#prompt redhat
 
setopt correctall
autoload compinstall
 
#漂亮又实用的命令高亮界面
setopt extended_glob
 TOKENS_FOLLOWED_BY_COMMANDS=('|' '||' ';' '&' '&&' 'sudo' 'do' 'time' 'strace')
 
 recolor-cmd() {
     region_highlight=()
     colorize=true
     start_pos=0
     for arg in ${(z)BUFFER}; do
         ((start_pos+=${#BUFFER[$start_pos+1,-1]}-${#${BUFFER[$start_pos+1,-1]## #}}))
         ((end_pos=$start_pos+${#arg}))
         if $colorize; then
             colorize=false
             res=$(LC_ALL=C builtin type $arg 2>/dev/null)
             case $res in
                 *'reserved word'*)   style="fg=magenta,bold";;
                 *'alias for'*)       style="fg=cyan,bold";;
                 *'shell builtin'*)   style="fg=yellow,bold";;
                 *'shell function'*)  style='fg=green,bold';;
                 *"$arg is"*)
                     [[ $arg = 'sudo' ]] && style="fg=red,bold" || style="fg=blue,bold";;
                 *)                   style='none,bold';;
             esac
             region_highlight+=("$start_pos $end_pos $style")
         fi
         [[ ${${TOKENS_FOLLOWED_BY_COMMANDS[(r)${arg//|/\|}]}:+yes} = 'yes' ]] && colorize=true
         start_pos=$end_pos
     done
 }
 check-cmd-self-insert() { zle .self-insert && recolor-cmd }
 #check-cmd-backward-delete-char() { zle .backward-delete-char && recolor-cmd }
 
 zle -N self-insert check-cmd-self-insert
 #zle -N backward-delete-char check-cmd-backward-delete-char
```
- 巴蛮子的烂笔头

```
 彩色的Shell

我常在命令行下工作，以前老被同事说＂你整天在那个黑窗口上倒腾什么？＂　现在这个问题变成了＂你这个花花绿绿的窗口是什么东西?＂

其实都是同一个东西：一个兼容于xterm的终端窗口，要么是PuTTY/KiTTY，要么是GNOME Terminal/Xfce Terminal/LXTerminal．不过我这半年将很多东西配上了颜色．

倒不是说我想搞得很花哨，而是有彩色的文字夹杂其中的话，文字的辨识度要高一些－－你是不是有很多时候在一大段输出当中找寻提示符上一次出现的位置? 是不是在里面找有没有某个单词？
1. Shell本身
1.1 提示符
bash

通过修改环境变量 PS1实现，只要里面包含适当的ANSI color sequence即可实现彩色．Debian/Ubuntu上bash提示符号默认有一份彩色配置，但要求自己编辑 ~/.bashrc，设置 force_color_prompt=yes　即可（找到 force_color_prompt=yes 这一行并删除前面的注释符号）．

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

CentOS默认没有彩色配置，可以用这两个在线工具来配置： .bashrc generator: create your .bashrc PS1 with a drag and drop interface　和 Bash $PS1 Generator 2.0　（后面这个好像被蔷了）．不过我在一些不想＂深度定制＂的机器上都是用下面的zsh方法来快速搞定．
zsh

没仔细研究怎么配置，好像是通过修改环境变量PROMPT实现．不过用zsh的人一般都会用oh-my-zsh或者prezto套件，里面都提供了丰富的配置模板．

不过zsh自带的也不少（效果参见 Zsh themes for prompts screenshots | blog post ），我在不特别常用的机器上一般都是如下几行：

autoload -Uz promptinit
promptinit
prompt adam2
# 用 prompt -l 可以列出所有的提示符配置，有兴趣可以逐个体验

我比较喜欢adam2这个，因为它可以醒目地将一次次的输入输出分隔开来．

图片来自: Zsh themes for prompts screenshots | blog post
1.2 命令行语法高亮

曾经试过用 fish 作为日常shell，但最后因为跟bash差异太大而放弃了（太多东西不兼容了，而zsh在兼容bash这方面就非常好），不过fish彩色的命令行给我留下了很深的印象：

但bash上面是搞不了这个功能了，zsh倒是有一个zsh-syntax-highlighting，安装方法如下:

mkdir -p ~/.zsh/plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/plugins/zsh-syntax-highlighting
echo "source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
source ~/.zshrc

2. ls
2.1 ls --color

大多数情况下，你执行 ls --color 就可以了，它会用彩色来区分不同的文件类型．

(此图来自: More than just colors: My bash settings | blogginess )

你可以添加 alias ls='ls --color=auto' 到你的 ~/.bashrc. auto 这个值可以确保你将 ls 的输出重定向到一个文件时不会产生问题．

如果你想要详细了解这个功能，可以阅读 coreutils　文档里面的相应章节： GNU Coreutils: General output formatting, GNU Coreutils: dircolors invocation (注意配置文件的详细说明其实在 dircolors --print-database 这个命令的输出里面）．这里还有一个在线配置工具: LSCOLORS Generator －－不过我从来没去配过细节．

    2016/06/02 补充:　默认配置下主要文件类型的对应颜色如下（另外默认配置里面还有不少按扩展名配置的颜色，这里不详细说明了）

2.2 k

ls --color 基本上是按照文件类型来确定颜色的．如果你想按照文件大小，新旧乃至git 状态来显示不同颜色，那么可以用这个针对zsh的小脚本: https://github.com/supercrabtree/k

wget -c https://github.com/supercrabtree/k/archive/master.zip -O k.zip
unzip k.zip
mkdir ~/.zsh/plugins
cp k-master/k.sh ~/.zsh/plugins
source ~/.zsh/plugins/k.sh

然后执行 k 就可以了（不过跟 ls --color　不同的是，颜色不是显示在文件名上的，而是大小／时间等列．

    2016/06/02 补充:　看到两个ls的彩色版

    exa https://github.com/ogham/exa

    ls++ https://github.com/trapd00r/ls--

3. 彩色的文档阅读
3.1 彩色的manpage阅读器:

第一个办法如下，不用安装任何其它东西（前提是采用 less作为pager -- 虽然一般情况下默认都是用这个）:

    export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
    export LESS_TERMCAP_md=$(tput bold; tput setaf 6) # cyan
    export LESS_TERMCAP_me=$(tput sgr0)
    export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4) # yellow on blue
    export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
    export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) # white
    export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
    export LESS_TERMCAP_mr=$(tput rev)
    export LESS_TERMCAP_mh=$(tput dim)
    export LESS_TERMCAP_ZN=$(tput ssubm)
    export LESS_TERMCAP_ZV=$(tput rsubm)
    export LESS_TERMCAP_ZO=$(tput ssupm)
    export LESS_TERMCAP_ZW=$(tput rsupm)

然后用 man date　就可以看到彩色的manpage了．

如果觉得这个麻烦，不太容易记得住的话，可以用另一个方法：安装 most ，然后执行 PAGER=most man date 就能看到彩色的mapage了（你也可以将 export MANPAGER=most 添加到 ~/.bashrc，这样以后 man date 就能直接调用这个 most 来阅读 manpage）．

出处： Unix / Linux: Display Color Man Pages
3.2 彩色的texinfo阅读器

安装 pinfo 就可以了．

参考： pinfo Linux / Unix Command: Read Info Documentation in Colors
4. git与mercurial的彩色配置
4.1 git

比较新一点的git　 (>= 1.8.4，因为该版本中将 ''color.ui'' 的默认值改为了 ''auto'' ）都会自动在 git status, git log, git diff 等等地方采用颜色．

如果你的git比较老，可以用下面的方法来开启颜色支持：

git config --global color.ui auto

当然也可以详细设置各个子命令是否要启用颜色支持:

sh git config --global color.status always git config --global color.grep auto git config --global color.diff auto git config --global color.branch never git config --global color.interactive autosh

详细的说明请参考 git -config 的手册（或者运行 git config --help）

参考:

    Git显示漂亮日志的小技巧
    让Git的输出更友好: 多种颜色和自定义log格式

4.2 mercurial

启用 Color 扩展 可以给 hg status , hg log和 hg diff 添加颜色．

配置方法: 编辑 ~/.hgrc

[extensions]
color =

效果:

具体颜色还可以自行定义，详情请参考 ColorExtension　的说明．

参考: mercurial的几个易用性小技巧 - 巴蛮子 - 博客园
5 高亮输出中的指定文字

有时候我们需要在一个程序的输出中找到某个单词， grep --color 是比较常用的一个方法：

grep --color 虽然挺不错（尤其是不需要另行安装），但它是一个 过滤 工具．然后有些时候我们只是要 高亮 输出中的某些文字，而 不想过滤 掉其它行，但很奇怪这样的诉求没有在基本工具集里面提供。
5.1 hhighlighter (bash插件)

<https://github.com/paoloantinori/hhighlighter>

这是一个bash脚本，它提供了一个h()函数（shell函数也是一种命令），可以用来高亮

安装:

      apt-get install ack-grep
      # or: curl http://beyondgrep.com/ack-2.14-single-file > ~/bin/ack && chmod 0755 ~/bin/ack
      mkdir -p ~/.bash/plugins/
      wget 'https://github.com/paoloantinori/hhighlighter/raw/master/h.sh' -O ~/.bash/plugins/h.sh
      echo "source ~/.bash/plugins/h.sh"
      source ~/.bash/plugins/h.sh

使用:

  $ h
  usage: YOUR_COMMAND | h [-i] [-d] pattern1 pattern2...
    -i : ignore case
    -d : disable regexp
    -n : invert colors

说明: hhighlighter传递多个参数时，每个参数会自动采用不同的颜色来高亮
5.2 colorex

<https://github.com/Scopart/colorex/>

这个小工具跟 hhighlighter 功能差不多，区别主要在实现层面： colorex是采用python实现的，而且是个独立脚本，比较容易在其它shell下面用．另外，它也不需要其它工具（比如hhighlighter需要ack）

安装:

  wget 'https://github.com/Scopart/colorex/raw/master/colorex' -O ~/bin/colorex
  chmod a+x ~/bin/colorex

使用:

      # to display every word "ERROR" in red of foo.txt
      colorex --red ERROR foo.txt
    
      # to watch logfile.txt displaying "WARNING" in yellow and "INFO" in green
      tail -f logfile.txt | colorex -y WARNING --green INFO
    
      # to display "(" and ")" contained in foo.txt in blue
      colorex -b '\(|\)' foo.txt

略微有点不爽的是，必须指定颜色参数，多个关键字时得指定多个颜色参数（不要被 colorex --help 显示的 -N 参数误导了，虽然它说是 " display with random colors　"，但并不是我们通常理解的随机选用一个颜色 :-(）

参考: https://inconsolation.wordpress.com/2014/08/03/colorex-i-might-as-well-include-them-all/
6. 支持语法高亮的编辑器
6.1 vim

首先确认你的vim是支持语法高亮的．确认方法是执行 :version 查看里面 syntax 一项是 +syntax 还是 -syntax，如果是后者就说明语法支持没有编译进来（另一种方法是执行 :syn ，如果得到错误信息 E319: Sorry the command is not available in this version　也说明不支持），你得安装其它版本（比如Ubuntu默认安装的 vim-tiny 版本是一个精简版不支持语法高亮，得再用 apt-get install vim 安装功能比较全的版本）或者重新编译．

然后就是开启语法高亮，打开文件之后执行 :syn on 即可．

如果你想默认开启此项，则可以把 syn on 放到 ~/.vimrc 里面（如果你从来没有编辑过 .vimrc, 那么我推荐你拷贝一个vim推荐配置: cp /usr/share/vim/vim7x/vimrc_example.vim ~/.vimrc ）

vim能够根据文件扩展名或者shebang (即文件头部的 #!/usr/bin/python )来识别文件类型，如果没有正确识别的话，你可以用 :set filetype=python 这个命令来强制vim　按python语法高亮当前文件（如果你期望vim下次打开时还是按python语法来对待当前文件，可以在文件头部或者尾部添加一行 # vim: set filetype=python （这一个包含了vim选项的行在vim里面称为modeline））

参考: Vim参考手册: 语法高亮 Vim参考手册: 文件类型
6.2 nano

我一直以为 nano 是不支持语法高亮的，所以对于为什么Cannonical会选择nano作为默认的编辑器感到奇怪：一个这么弱的编辑器居然还．．．不过后来才发现我错了（主要是我一直只用vim和emacs，程序用其它编辑器打开文件后我就赶紧退出来设置环境变量 EDITOR 了之后再进去 :-)

nano 自带了十来种常见编程语言的语法高亮配置，配置文件在 /usr/share/nano 目录下，但需要你将它们 include 到你的 ~/.nanorc 才能起作用（Debian和Ubuntu在 /etc/nanorc 里面已经默认包含了，但CentOS里面没有）
6.3 joe

joe 是我很喜欢的编辑器，因为仅仅1M的体积，但可以模拟一个微型的Emacs来用（joe可以模拟好几种编辑器: Emacs, WordStar, Pico－－而nano其实是模仿了Pico），而且屏幕上会显示常用快捷键提示，另外 F1/F2/F3/F4 调用shell很方便(这个功能需要4.0版本以上）．

当然，它还支持语法高亮，支持40多种编程语言和（这是Debian 7/8, Ubuntu 12.04/14.04和CentOS 6 (epel)里面所带的3.7版本的情况，而到了4.1版本已经增长了70多种．joe的编译安装相当简单，所以推荐使用最新版本，不想自己编译的也可以自己添加一些新的语法高亮配置: https://github.com/cmur2/joe-syntax．

```
