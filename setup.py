#!/bin/python

import os
import os.path
import platform
import sys
import subprocess

PLATFORM = platform.system()
IS_MAC = PLATFORM == 'Darwin'
IS_LINUX = PLATFORM == 'Linux'
IS_WINDOWS = PLATFORM == 'Windows'

DIR_PATH = os.path.dirname(os.path.realpath(__file__))

def call_shell(command):
    return subprocess.call(command, shell=True)

def command_exists(command):
    return not call_shell('which {} > /dev/null'.format(command))

def install_zsh():
    if command_exists('zsh'):
        return

    if IS_LINUX:
        call_shell('sudo apt-get install zsh')

def install_fasd():
    if command_exists('fasd'):
        return

    if IS_LINUX:
        call_shell(
            'sudo add-apt-repository ppa:aacebedo/fasd'
            ' && sudo apt-get update'
            ' && sudo apt-get install fasd'
        )

def install_nvm():
    if command_exists('nvm'):
        return

    call_shell('git clone https://github.com/creationix/nvm.git ~/.nvm')

def script():

    if os.environ['USER'] == 'root':
        print 'Do not run this script as root'
        sys.exit(1)

    response = raw_input(
        'This script overwrite dotfiles in your home directory.'
        ' Continue? [y/N]? ',
    )
    if response != 'y':
        sys.exit(1)

    install_fasd()
    install_nvm()
    install_zsh()

    call_shell('sudo chsh -s $(which zsh) $USER')

    DOTFILES = [
        '.ackrc',
        '.gitconfig',
        '.gitignore_global',
        '.gvimrc',
        '.tmux.conf',
        '.vim',
        '.vimrc',
        '.zshrc',
    ]
    for dotfile in DOTFILES:
        call_shell(
            'ln -sf {dir_path}/{dotfile} ~/{dotfile}'.format(
                dir_path=DIR_PATH, dotfile=dotfile,
            )
        )

    call_shell('mkdir -p ~/bin')
    call_shell('ln -sf {}/tmux_renum.sh ~/bin/tmux_renum.sh'.format(DIR_PATH))

    call_shell('rm -rf ~/.vim/ && mkdir -p ~/.vim')
    vundle_path = '~/.vim/bundle/Vundle.vim'
    call_shell(
        'git clone https://github.com/VundleVim/Vundle.vim {vundle_path}'
        ' && vim +PluginInstall +qall'.format(vundle_path=vundle_path)
    )
    call_shell('ln -sf {dir_path}/.vim/ftplugin ~/.vim/ftplugin')

    call_shell(
        'rm -rf ~/.oh-my-zsh'
        ' && git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh'
    )

    print 'Log out and back in to start using Zsh'

if __name__ == '__main__':
    script()
else:
    print 'Cannot be imported'
    sys.exit(1)
