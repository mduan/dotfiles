#!/usr/bin/env python2

import os
import os.path
import platform
import socket
import sys
import subprocess

PLATFORM = platform.system()
IS_MAC = PLATFORM == 'Darwin'
IS_LINUX = PLATFORM == 'Linux'
IS_WINDOWS = PLATFORM == 'Windows'

host_name = socket.gethostname()
IS_WORK_LAPTOP = host_name in ['C02RT09FG8WL-mackduan', 'C02FL7URMD6M-mackduan']

DIR_PATH = os.path.dirname(os.path.realpath(__file__))

def call_shell(command):
    return subprocess.call(command, shell=True)

def command_exists(command):
    return not call_shell('which {} > /dev/null'.format(command))

def path_exists(p):
    return os.path.exists(os.path.expanduser(p))

# region installations

def install_ag():
    if command_exists('ag'):
        return

    if IS_LINUX:
        call_shell('sudo apt-get install silversearcher-ag')
    elif IS_MAC:
        call_shell('brew install the_silver_searcher')

def install_fasd():
    if command_exists('fasd'):
        return

    if IS_LINUX:
        call_shell(
            'sudo add-apt-repository ppa:aacebedo/fasd'
            ' && sudo apt-get update'
            ' && sudo apt-get install fasd'
        )
    elif IS_MAC:
        call_shell('brew install fasd')

def install_fzf():
    if command_exists('fzf'):
        return

    if IS_LINUX:
        call_shell(
            'rm ~/.fzf'
            ' && git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf'
            ' && ~/.fzf/install'
        )
    elif IS_MAC:
        call_shell('brew install fzf')
        call_shell('$(brew --prefix)/opt/fzf/install')

def install_google_cloud_sdk():
    if command_exists('gcloud'):
        return

    if not path_exists('~/google-cloud-sdk'):
        call_shell(
            'curl -o /tmp/google-cloud-sdk.tar.gz https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz'
            ' && tar -xzf /tmp/google-cloud-sdk.tar.gz --directory ~/'
        )

    call_shell('~/google-cloud-sdk/install.sh')
    print("Remember to run 'gcloud auth login'")

def install_tmux():
    if command_exists('tmux'):
        return

    if IS_LINUX:
        call_shell('sudo apt-get install tmux')
    elif IS_MAC:
        call_shell('brew install tmux')

def install_zsh():
    if command_exists('zsh'):
        return

    if IS_LINUX:
        call_shell('sudo apt-get install zsh')
    elif IS_MAC:
        call_shell('brew install zsh')

# endregion

# region mac installations

def install_homebrew():
    if command_exists('brew'):
        return

    call_shell('/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"')

def install_sleep_watcher():
    if not call_shell('brew ls | grep sleepwatcher'):
        return

    call_shell('brew install sleepwatcher')
    call_shell('brew services start sleepwatcher')
    print 'Installed SleepWatcher. Remember to enable permissions in Security & Privacy'

def install_blueutil():
    if command_exists('blueutil'):
        return

    call_shell('brew install blueutil')

def install_jq():
    if command_exists('jq'):
        return

    call_shell('brew install jq')

def install_docker():
    if path_exists('/Applications/Docker.app'):
        return

    call_shell('brew install --cask docker')

# endregion

def script():

    additional_instructions = []

    if os.environ['USER'] == 'root':
        print 'Do not run this script as root'
        sys.exit(1)

    response = raw_input(
        'This script overwrite dotfiles in your home directory.'
        ' Continue? [y/N]? ',
    )
    if response != 'y':
        sys.exit(1)

    if IS_LINUX:
        call_shell('sudo apt-get update')
    if IS_MAC:
        install_homebrew()
        call_shell('brew doctor')
        install_sleep_watcher()
        install_blueutil()

    install_ag()
    install_fasd()
    install_fzf()
    install_tmux()
    install_zsh()

    call_shell('sudo chsh -s $(which zsh) $USER')

    DOTFILES = [
        '.agignore',
        '.gitconfig',
        '.gitignore_global',
        '.gvimrc',
        '.ideavimrc',
        '.tmux.conf',
        '.vimrc',
        '.zshrc',

        # region Mac OS specific
        # TODO(mack): Limit copying these files to just Mac OS systems

        # For SleepWatcher on Mac OS
        '.sleep',
        '.wakeup',
        'sleepwatch_helper.py',

        # endregion
    ]

    for dotfile in DOTFILES:
        call_shell(
            'ln -sf {dir_path}/{dotfile} ~/{dotfile}'.format(
                dir_path=DIR_PATH, dotfile=dotfile,
            )
        )
    if IS_MAC:
        additional_instructions.append('If using iTerm, remember to set color preset to Solarized: https://stackoverflow.com/a/40727851')

    call_shell('mkdir -p ~/bin')
    call_shell('ln -sf {dir_path}/tmux_renum.sh ~/bin/tmux_renum.sh'.format(dir_path=DIR_PATH))

    call_shell('rm -rf ~/.vim/ && mkdir -p ~/.vim/bundle')
    vundle_path = '~/.vim/bundle/Vundle.vim'
    call_shell(
        'git clone https://github.com/VundleVim/Vundle.vim {vundle_path}'
        ' && vim +PluginInstall +qall'.format(vundle_path=vundle_path)
    )
    call_shell('ln -sf {dir_path}/.vim/ftplugin ~/.vim/ftplugin'.format(dir_path=DIR_PATH))

    call_shell(
        'rm -rf ~/.oh-my-zsh'
        ' && git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh'
    )

    call_shell(
        'rm -rf ~/.tmux/plugins'
        ' && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm'
    )
    # TODO: automate the following instruction
    additional_instructions.append('Start tmux, then press prefix + I to fetch the plugin and source it.')

    install_google_cloud_sdk()
    if IS_WORK_LAPTOP:
        install_jq()
        install_docker()
        print("Remember to 'gcloud auth configure-docker'")

    print
    print 'Additional instructions:'
    for instruction in additional_instructions:
        print '- {}'.format(instruction)
    print

    print 'Log out and back in to start using Zsh'

if __name__ == '__main__':
    script()
else:
    print 'Cannot be imported'
    sys.exit(1)
