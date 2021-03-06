#export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/texbin:/Applications/CMake\ 2.8-8.app/Contents/bin:/Applications/Xcode.app/Contents/Developer/usr:/Applications/Ghostscript.app:/Applications/Ghostscript.app/bin:/usr/local/texlive/2012/bin/x86_64-darwin:$PATH

#PKG_CONFIG_PATH=$usr/local/lib/pkgconfig/:${PKG_CONFIG_PATH}
#export PKG_CONFIG_PATH
#export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:${PKG_CONFIG_PATH}
# DYLD_FALLBACK_LIBRARY_PATH=$/usr/local/lib:$DYLD_FALLBACK_LIBRARY_PATH
# export DYLD_FALLBACK_LIBRARY_PATH
# export INCLUDE_PATH=/usr/local/include/opencv:/usr/local/include/opencv2:$INCLUDE_PATH

typeset -U path cdpath fpath manpath

#emacs上でzshを動かす設定
[[ $EMACS = t ]] && unsetopt zle


#==================================================
#コピペ設定 http://news.mynavi.jp/column/zsh/022/index.html より
#==================================================

# users generic .zshrc file for zsh(1)

## Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8


## Default shell configuration
#
# set prompt
#
autoload colors
colors
case ${UID} in
0)
#    PROMPT="%B%{${fg[red]}%}%/#%{${reset_color}%}%b "
#    PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
#    SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
PROMPT='[%F{red}%B%n%b%f@%F{blue}%U%m%u%f]# '
PROMPT2='[%F{red}%B%n%b%f@%F{blue}%U%m%u%f]# '
SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
RPROMPT='[%F{green}%d%f]'
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
    ;;
*)
#    PROMPT="%{${fg[red]}%}%/%%%{${reset_color}%} "
#    PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
#    SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
PROMPT='[%F{red}%B%n%b%f@%F{blue}%U%m%u%f]# '
PROMPT2='[%F{red}%B%n%b%f@%F{blue}%U%m%u%f]# '
SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
RPROMPT='[%F{green}%d%f]'
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
    ;;
esac

# auto change directory
#
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

# command correct edition before each completion attempt
#
setopt correct

# compacked complete list display
#
setopt list_packed

# no remove postfix slash of command line
#
setopt noautoremoveslash

# no beep sound when complete list displayed
#
setopt nolistbeep


## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a goes to head of a line and Ctrl-e goes 
#   to end of it)
#
bindkey -e

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end


## Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data


## Completion configuration
#
#fpath=(~/.zsh/functions/Completion ${fpath})
fpath=(/usr/local/share/zsh-completions $fpath)
autoload -U compinit
compinit -u


## zsh editor
#
autoload zed


## Prediction configuration
#
#autoload predict-on
#predict-off


## Alias configuration
#
# expand aliases before completing
#
setopt complete_aliases     # aliased ls needs if file/dir completions work

alias where="command -v"
alias j="jobs -l"

case "${OSTYPE}" in
freebsd*|darwin*)
    alias ls="ls -G -w"
    ;;
linux*)
    alias ls="ls --color"
    ;;
esac

alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"

alias du="du -h"
alias df="df -h"

alias su="su -l"

case "${OSTYPE}" in
darwin*)
    alias updateports="sudo port selfupdate; sudo port outdated"
    alias portupgrade="sudo port upgrade installed"
    ;;
freebsd*)
    case ${UID} in
    0)
        updateports() 
        {
            if [ -f /usr/ports/.portsnap.INDEX ]
            then
                portsnap fetch update
            else
                portsnap fetch extract update
            fi
            (cd /usr/ports/; make index)

            portversion -v -l \<
        }
        alias appsupgrade='pkgdb -F && BATCH=YES NO_CHECKSUM=YES portupgrade -a'
        ;;
    esac
    ;;
esac


## terminal configuration
#
unset LSCOLORS
case "${TERM}" in
xterm)
    export TERM=xterm-color
    ;;
kterm)
    export TERM=kterm-color
    # set BackSpace control character
    stty erase
    ;;
cons25)
    unset LANG
    export LSCOLORS=ExFxCxdxBxegedabagacad
    export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors \
        'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
esac

# set terminal title including current directory
#
case "${TERM}" in
kterm*|xterm*)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    export LSCOLORS=exfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors \
        'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
esac


## load user .zshrc configuration file
#
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine

#================================================
#screen
#================================================
## screen auto startup
## [username]のところは置き換えて使う
#if [ $TERM != "screen" -a "`screen -ls | grep Attache`" = "" ]; then
#    screen -US joea -xRR
#fi
#
##screenのステータスラインに最後に実行したコマンドを表示
#if [ "$TERM" = "screen" ]; then
#    #chpwd () { echo -n "_`dirs`\\" }
#    preexec() {
#        # see [zsh-workers:13180]
#        # http://www.zsh.org/mla/workers/2000/msg03993.html
#        emulate -L zsh
#        local -a cmd; cmd=(${(z)2})
#        case $cmd[1] in
#            fg)
#                if *1; then
#                    cmd=(builtin jobs -l %+)
#                else
#                    cmd=(builtin jobs -l $cmd[2])
#                fi
#                ;;
#            %*) 
#                cmd=(builtin jobs -l $cmd[1])
#                ;;
#            cd)
#                if *2; then
#                    cmd[1]=$cmd[2]
#                fi
#                ;&
#            *)
#                echo -n "k$cmd[1]:t\\"
#                return
#                ;;
#        esac
#
#        local -A jt; jt=(${(kv)jobtexts})
#
#        $cmd >>(read num rest
#            cmd=(${(z)${(e):-\$jt$num}})
#            echo -n "k$cmd[1]:t\\") 2>/dev/null
#    }
#    chpwd () {}
#fi

## create emacs env file
perl -wle \
    'do { print qq/(setenv "$_" "$ENV{$_}")/ if exists $ENV{$_} } for @ARGV' \
    PATH > ~/.emacs.d/shellenv.el
