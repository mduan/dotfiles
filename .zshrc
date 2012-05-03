export PATH=/usr/local/bin:${PATH}

source /etc/profile

###########################################################        
# Options for Zsh

export HISTFILE=~/.zsh_history
export HISTSIZE=50000
export SAVEHIST=50000
eval `dircolors -b`

# auto completions
autoload -U compinit compinit
compinit
bindkey '^[[Z' reverse-menu-complete

# support emac shortcuts i.e. <C-A>, <C-E>, <C-W>
bindkey -e

# case-insensitive (all),partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

setopt autopushd pushdminus pushdsilent pushdtohome
setopt autocd
setopt cdablevars
setopt ignoreeof
setopt interactivecomments
setopt nobanghist
setopt noclobber
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt SH_WORD_SPLIT
setopt nohup
setopt share_history

zstyle ':completion:*' menu select
prompt=walters

# PS1 and PS2
export PS1="$(print '%{\e[1;32m%}%n@%m%{\e[0m%}'):$(print '%{\e[0;32m%}%~%{\e[0m%}')$ "
export PS2="$(print '%{\e[0;32m%}>%{\e[0m%}')"

## If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#	PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#	;;
#*)
#	;;
#esac

# Vars used later on by Zsh
export EDITOR=vim
export BROWSER=links
export XTERM="aterm +sb -geometry 80x29 -fg black -bg lightgoldenrodyellow -fn -xos4-terminus-medium-*-normal-*-14-*-*-*-*-*-iso8859-15"

##################################################################
# Stuff to make my life easier

# allow approximate
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# tab completion for PID :D
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

# cd not select parent dir
zstyle ':completion:*:cd:*' ignore-parents parent pwd

##################################################################
# Key bindings
# http://mundy.yazzy.org/unix/zsh.php
# http://www.zsh.org/mla/users/2000/msg00727.html

typeset -g -A key
bindkey '^?' backward-delete-char
bindkey '^[[1~' beginning-of-line
bindkey '^[[5~' up-line-or-history
bindkey '^[[3~' delete-char
bindkey '^[[4~' end-of-line
bindkey '^[[6~' down-line-or-history
bindkey '^[[A' up-line-or-search
bindkey '^[[D' backward-char
bindkey '^[[B' down-line-or-search
bindkey '^[[C' forward-char 
# completion in the middle of a line
bindkey '^i' expand-or-complete-prefix

##################################################################
# My aliases

# Set up auto extension stuff
alias -s html=$BROWSER
alias -s org=$BROWSER
alias -s php=$BROWSER
alias -s com=$BROWSER
alias -s net=$BROWSER
alias -s png=feh
alias -s jpg=feh
alias -s gif=feg
alias -s sxw=soffice
alias -s doc=soffice
alias -s gz=tar -xzvf
alias -s bz2=tar -xjvf
alias -s java=$EDITOR
alias -s txt=$EDITOR
alias -s PKGBUILD=$EDITOR

# Normal aliases
alias ls='ls --color=auto -F'
alias ll='ls -al'
alias lsd='ls -ld *(-/DN)'
alias lsa='ls -ld .*'
alias f='find |grep'
alias c="clear"
alias dir='ls -1'
alias gvim='gvim -geom 82x35'
alias ..='cd ..'
alias nicotine='/home/paul/downloads/nicotine-1.0.8rc1/nicotine'
alias ppp-on='sudo /usr/sbin/ppp-on'
alias ppp-off='sudo /usr/sbin/ppp-off'
alias firestarter='sudo su -c firestarter'
alias mpg123='mpg123 -o oss'
alias mpg321='mpg123 -o oss'
#alias vba='/home/paul/downloads/VisualBoyAdvance -f 4'
alias hist="grep '$1' /home/mack/.zsh_history"
#alias irssi="irssi -c irc.freenode.net -n yyz"
alias mem="free -m"
#alias msn="tmsnc -l hutchy@subdimension.com"
alias go='gnome-open'
#alias trash='trash-put'
#alias trash-restore='restore-trash'

#mkdir and cd
function take() {
	mkdir -p $1 && cd $1
}

# command L equivalent to command |less
alias -g L='|less'

# command S equivalent to command &> /dev/null &
alias -g S='&> /dev/null &'

# type a directory's name to cd to it
compctl -/ cd

export JDK_HOME="/usr/lib/jvm/jdk1.6.0_20"

export EDITOR=/usr/bin/vim

export FB_UID=1647810326

# map Caps Lock to Esc
# xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'

# set readline in Vi mode
#set -o vi

source /etc/profile.d/autojump.zsh

if [ -r ~/.zshrc.local ]
then
  source ~/.zshrc.local
fi
