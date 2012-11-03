source /etc/profile

# type a directory's name to cd to it
compctl -/ cd

# export environment variables
export PATH=/usr/local/bin:${PATH}
export BROWSER=links
export EDITOR=vim
export XTERM="aterm +sb -geometry 80x29 -fg black -bg lightgoldenrodyellow -fn -xos4-terminus-medium-*-normal-*-14-*-*-*-*-*-iso8859-15"
export JDK_HOME="/usr/lib/jvm/jdk1.6.0_20"
export HISTFILE=~/.zsh_history
export HISTSIZE=50000
export SAVEHIST=50000

###########################################################
# Options for Zsh

# setopts
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

# bindkey -e  # support emac shortcuts i.e. <C-A>, <C-E>, <C-W>
set -o vi  # set readline in Vi mode

# visual settings -----------------

# color setup for 'ls'
eval `dircolors -b`

# Path to your oh-my-zsh configuration.
ZSH=$HOME/git_clones/oh-my-zsh
#
# # Set name of the theme to load.
# # Look in ~/.oh-my-zsh/themes/
# # Optionally, if you set this to "random", it'll load a random theme each
# # time that oh-my-zsh is loaded.
ZSH_THEME="kphoen"
#
# # Example aliases
# # alias zshconfig="mate ~/.zshrc"
# # alias ohmyzsh="mate ~/.oh-my-zsh"
#
# # Set to this to use case-sensitive completion
# # CASE_SENSITIVE="true"
#
# # Comment this out to disable weekly auto-update checks
# # DISABLE_AUTO_UPDATE="true"
#
# # Uncomment following line if you want to disable colors in ls
# # DISABLE_LS_COLORS="true"
#
# # Uncomment following line if you want to disable autosetting terminal title.
# # DISABLE_AUTO_TITLE="true"
#
# # Uncomment following line if you want red dots to be displayed while waiting for completion
# # COMPLETION_WAITING_DOTS="true"
#
# # Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# # Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# # Example format: plugins=(rails git textmate ruby lighthouse)
# plugins=(git)
#
source $ZSH/oh-my-zsh.sh

# Faster git completion
__git_files () {
  _wanted files expl 'local files' _files
}

# completions -------------------------

autoload -U compinit compinit
compinit
bindkey '^[[Z' reverse-menu-complete

# case-insensitive (all),partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# TODO: document this
zstyle ':completion:*' menu select

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
bindkey '^R' history-incremental-search-backward
bindkey '^F' history-incremental-search-forward
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
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

# Set up auto extension stuff
#alias -s org=$BROWSER
#alias -s com=$BROWSER
#alias -s net=$BROWSER
#alias -s html=$EDITOR
#alias -s java=$EDITOR
#alias -s php=$EDITOR
#alias -s py=$EDITOR
#alias -s txt=$EDITOR
#alias -s gz=tar -xzvf
#alias -s bz2=tar -xjvf
#alias -s zip=unzip

# Normal aliases
# alias -g L='|less' # command L equivalent to command |less
# alias -g S='&> /dev/null &' # command S equivalent to command &> /dev/null &
#alias ..='cd ..'
#alias c="clear"
#alias dir='ls -1'
alias f='find |grep'
alias ll='ls -al'
alias ls='ls --color=auto -F'
alias lsa='ls -ld .*'
alias lsd='ls -ld *(-/DN)'
alias go='gnome-open'
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"
alias grep="grep --color=auto"
alias gvim='gvim -geom 82x35'
alias hist="grep '$1' /home/mack/.zsh_history"
alias mem='free -m'
alias tmux2='tmux -2 attach -d || tmux -2'
#alias trash='trash-put'
#alias trash-restore='restore-trash'

alias d='git diff'
alias g='git graph'
alias s='git status'

# pwd, but collapse $HOME to ~
function pwdc()  {
  local name=`pwd`
  [[ "$name" =~ ^"$HOME"(/|$) ]] && name="~${name#$HOME}"
  echo "$name"
}

function take() { mkdir -p $1 && cd $1 } # mkdir and cd

[[ -s ~/.autojump/etc/profile.d/autojump.zsh ]] && source ~/.autojump/etc/profile.d/autojump.zsh

if [ -r ~/.zshrc.local ]
then
  source ~/.zshrc.local
fi
