export PATH="/usr/local/bin:${PATH}"

[[ -d /home/mack ]]; IS_SL_DEVBOX=$?
[[ -d /home/mack-gcp ]]; IS_GCP_DEVBOX=$?
[[ "$IS_SL_DEVBOX" == 0 ]] || [[ "$IS_GCP_DEVBOX" == 0 ]]; IS_DEVBOX=$?
[[ -d /Users/mackduan/mixpanel ]]; IS_WORK_LAPTOP=$?

if [[ "$IS_DEVBOX" == 0 ]]; then
  # This has to happen early in this file because it sets certain terminal styles that
  # override my own settings.
  source "$HOME/analytics/.shellenv"
fi

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="kphoen"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git fasd virtualenv)

# For some reason, this is needed even though fasd is specified as a plugin above.
eval "$(fasd --init auto)"

# User configuration

# export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

PROMPT="$(virtualenv_prompt_info)$PROMPT"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export PYENV_ROOT="${HOME}/.pyenv"
if [ -d "${PYENV_ROOT}" ]; then
  export PATH="${PYENV_ROOT}/bin:${PATH}"
  eval "$(pyenv init -)"
fi

# https://github.com/clvv/fasd
alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection

# export environment variables
export BROWSER=links
export EDITOR=vim
export HISTFILE=~/.zsh_history
export HISTSIZE=50000
export SAVEHIST=50000

###########################################################
# Options for Zsh

# setopts
setopt autopushd pushdminus pushdsilent pushdtohome
setopt autocd
setopt cdablevars
setopt interactivecomments
setopt nobanghist
setopt noclobber
setopt hist_reduce_blanks
setopt hist_ignore_dups
setopt hist_ignore_space
setopt inc_append_history
setopt share_history
setopt sh_word_split
setopt nohup
setopt share_history

# bindkey -e  # support emac shortcuts i.e. <C-A>, <C-E>, <C-W>
set -o vi  # set readline in Vi mode

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
alias grep='grep --color=auto'
alias ls='ls -G -F'
alias ag='ag --pager less --hidden'

function take() { mkdir -p $1 && cd $1 } # mkdir and cd

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
. "$NVM_DIR/nvm.sh"

if [[ "$IS_DEVBOX" == 0 ]]; then
  export VIRTUAL_ENV="$HOME/env"
elif [[ "$IS_WORK_LAPTOP" == 0 ]]; then
  if [ -d ~/.virtualenvs/analytics ]; then
    source ~/.virtualenvs/analytics/bin/activate
  fi
fi

if [[ "$IS_SL_DEVBOX" == 0 ]]; then
  export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/jre

  source "$HOME/google-cloud-sdk/path.zsh.inc"
  source "$HOME/google-cloud-sdk/completion.zsh.inc"

  source "$HOME/analytics/google-cloud/scripts/define_aliases.sh"
  source "$HOME/analytics/google-cloud/scripts/kube.sh"
elif [[ "$IS_GCP_DEVBOX" == 0 ]]; then
  source ~/.gcpdevbox
elif [[ "$IS_WORK_LAPTOP" == 0 ]]; then
  source "$HOME/google-cloud-sdk/path.zsh.inc"
  source "$HOME/google-cloud-sdk/completion.zsh.inc"
fi

if [[ "$IS_GCP_DEVBOX" == 0 ]]; then
  if [[ -S "$SSH_AUTH_SOCK" && ! -h "$SSH_AUTH_SOCK" ]]; then
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock;
  fi
  export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock;
fi
