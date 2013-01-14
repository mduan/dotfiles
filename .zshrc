source /etc/profile

# Path to your oh-my-zsh configuration.
ZSH=$HOME/git_clones/oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="kphoen"

# display red dots while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

unsetopt correct_all

# export environment variables
export PATH=/usr/local/bin:/usr/local/share/npm/bin:/usr/local/Cellar/vim/7.3.691/bin:${PATH}
export BROWSER=links
export EDITOR=vim
export HISTFILE=~/.zsh_history
export HISTSIZE=50000
export SAVEHIST=50000

export WORKON_HOME=$HOME/.virtualenvs
mkdir -p ${WORKON_HOME}
#source /usr/local/bin/virtualenvwrapper.sh

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
#eval `dircolors -b`

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

##############################################################

# Key bindings
# http://mundy.yazzy.org/unix/zsh.php
# http://www.zsh.org/mla/users/2000/msg00727.html
typeset -g -A key
bindkey '^R' history-incremental-search-backward
bindkey '^F' history-incremental-search-forward
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

##############################################################

# Set up auto extension stuff
#alias -s py=$EDITOR

# Normal aliases
alias gd='git diff'
alias gg='git graph'
alias gs='git status'
alias grep="grep --color=auto"
alias hist="grep '$1' /home/mack/.zsh_history"
alias ls='ls -G -F'

function take() { mkdir -p $1 && cd $1 } # mkdir and cd

if [[ -f `which brew` ]] && [[ -f `brew --prefix`/etc/autojump.zsh ]]; then
  source `brew --prefix`/etc/autojump.zsh
elif [ -f ~/.autojump/etc/profile.d/autojump.zsh ]; then
  source ~/.autojump/etc/profile.d/autojump.zsh
fi

if [ -f ~/.zshrc.local ]
then
  source ~/.zshrc.local
fi
