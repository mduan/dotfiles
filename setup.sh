#!/bin/bash
set -e
[[ "$USER" == "root" ]] && echo "Do not run this script as root" && exit
read -p "This script will overwrite dotfiles in your home directory. Continue? [y/n]? " REPLY
[[ "$REPLY" != "y" ]] && exit

# TODO: manually
# if [ -e /usr/share/terminfo/x/xterm-256color ]; then
#   export TERM='xterm-256color'
# else
#   export TERM='xterm-color'
# fi

sudo apt-get install zsh
sudo chsh -s /bin/zsh

sudo apt-get install git-core
sudo apt-get install tmux
sudo apt-get install vim
# TODO: should be doing this with an array
sh -c 'rm -rf ~/.dotfiles/ && git clone git://github.com/mduan/dotfiles.git ~/.dotfiles/ && ln -sf ~/.dotfiles/.zshrc ~/.zshrc && ln -sf ~/.dotfiles/.vimrc ~/.vimrc && ln -sf ~/.dotfiles/.gvimrc ~/.gvimrc && rm -rf ~/.vim && ln -sf ~/.dotfiles/.vim ~/.vim && ln -sf ~/.dotfiles/.gitconfig ~/.gitconfig && ln -sf ~/.dotfiles/.tmux.conf ~/.tmux.conf'

sh -c 'mkdir -p ~/.zsh && rm -rf ~/.zsh/git-prompt && git clone https://github.com/olivierverdier/zsh-git-prompt.git ~/.zsh/git-prompt'

sudo apt-get install ruby-dev # need it for mkmf needed by Command-T
sh -c 'rm -rf ~/.vim/bundle/vundle && git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle/ && vim -c "silent BundleInstall" -c "silent helptags ~/.vim/bundle/vundle/doc" -c "silent qa!" && cd ~/.vim/bundle/Command-T/ruby/command-t && ruby extconf.rb && make && cd -'

sh -c 'rm -rf /tmp/git_autojump/ && git clone https://github.com/joelthelion/autojump.git /tmp/git_autojump/ && cd /tmp/git_autojump/ && chmod a+x install.sh && ./install.sh --local --zsh --force'

# any additional packages that might be worth installing
sudo apt-get install vim-gnome; # contains more extensions than vim package (i.e. clipboard support)
# sudo apt-get install trash-cli; # use trash rather than rm to move to trash bin
# sudo apt-get install nautilus-open-terminal; # open terminal in current directory from nautilus
# sudo apt-get install vlc;
# sudo apt-get install synapse;
# sudo apt-get install chromium;
# sudo apt-get install lamp-server^;
# sudo apt-get install phpmyadmin;
# sudo apt-get install valgrind;
# sudo sudo apt-get install moblock blockcontrol mobloquer; # peerguardian for linux
# sudo apt-get install alien; # convert rpm to dpkg compatible
# sudo apt-get install sun-java6-jre sun-java6-plugin; # java web plugin
# sudo apt-get install compizconfig-settings-manager;
# sudo apt-get install compiz-plugins-extra;

echo "Log out and back in to use Zsh"

# THINGS TO CONSIDER

# Crossover => Microsoft Office 2007

# Setup grid in Compiz

# Terminal unlimited scrollback

# Get Gmail desktop notifier

# Brother DCP-7030
# See https://bugs.launchpad.net/ubuntu/+source/cups/+bug/701856 (Yousry Abdallah solution) until Brother releases new version of driver
# printer drivers (cups/lpr): http://welcome.solutions.brother.com/bsc/public_s/id/linux/en/download_prn.html
# scanner drivers: http://welcome.solutions.brother.com/bsc/public_s/id/linux/en/download_scn.html
# note: scan-key-tool allows for initiating scan from printer to computer

# Nvidia Optimus
# See bumblebee:
# http://www.omgubuntu.co.uk/2011/05/bumbleebee-brings-nvidia-optimus-gpu-switching-to-linux-users/
# https://github.com/MrMEEE/bumblebee
# Note: future kernel release should allow for optimus functionality (i.e. auto graphics card switching)

# Setup Dropbox
# ln -s /media/sda5/Dropbox ~/Dropbox

# Specific issues -----------------------------------------------
# Disable audio when headphones unplugged like Windows 7
# from: http://askubuntu.com/questions/23508/how-to-automatically-change-volume-level-when-un-plugging-headphones
# [1] vim /etc/pulse/default.pa
# [2] s/load-module module-udev-detect/load-module module-udev-detect ignore_dB=1/
# [3] kill and restart pulseaudio
