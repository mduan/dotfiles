#!/bin/bash

# TODO: remember to uncomment necessary apt-get install's for first setup

set -e
[[ "$USER" == "root" ]] && echo "Do not run this script as root" && exit
read -p "This script will overwrite dotfiles in your home directory. Continue? [y/n]? " REPLY
[[ "$REPLY" != "y" ]] && exit

SCRIPT=`readlink -f $0`
# Absolute path this script is in, thus /home/user/bin
DOTFILES_PATH=`dirname $SCRIPT`

# TODO: manually
# if [ -e /usr/share/terminfo/x/xterm-256color ]; then
#   export TERM='xterm-256color'
# else
#   export TERM='xterm-color'
# fi

sudo apt-get install --force-yes --yes build-essential
sudo apt-get install --force-yes --yes x11-xserver-utils # install xmodmap

sudo apt-get install --force-yes --yes zsh
chsh -s /bin/zsh

sudo apt-get install --force-yes --yes git-core

#sudo apt-get install --force-yes tmux
sudo apt-get install --force-yes --yes libevent-dev
sudo apt-get install --force-yes --yes libncurses5-dev
sh -c 'sudo apt-get --force-yes --yes remove tmux && cd /tmp && wget http://downloads.sourceforge.net/project/tmux/tmux/tmux-1.5/tmux-1.5.tar.gz && rm -rf /tmp/tmux-1.5 && tar xzf tmux-1.5.tar.gz && cd - && cd /tmp/tmux-1.5 && ./configure && make && sudo make install && cd -'
sudo apt-get install --force-yes --yes xclip

# version of vim compiled w/ a gnome2 gui & support for scripting w/ perl, python, ruby, and tcl
sudo apt-get install --force-yes --yes vim-gnome
sudo apt-get install --force-yes --yes ack-grep

# TODO: should be doing this with an array
sh -c "ln -sf $DOTFILES_PATH/.zshrc ~/.zshrc && ln -sf $DOTFILES_PATH/.vimrc ~/.vimrc && ln -sf $DOTFILES_PATH/.gvimrc ~/.gvimrc && rm -rf ~/.vim && ln -sf $DOTFILES_PATH/.vim ~/.vim && ln -sf $DOTFILES_PATH/.gitconfig ~/.gitconfig && ln -sf $DOTFILES_PATH/.gitignore_global ~/.gitignore_global && ln -sf $DOTFILES_PATH/.ackrc ~/.ackrc && ln -sf $DOTFILES_PATH/.tmux.conf ~/.tmux.conf"

sh -c 'mkdir -p ~/.zsh && rm -rf ~/.zsh/git-prompt && git clone https://github.com/olivierverdier/zsh-git-prompt.git ~/.zsh/git-prompt'

sudo apt-get install --force-yes --yes ruby
sudo apt-get install --force-yes --yes ruby-dev # need it for mkmf needed by Command-T
sh -c 'rm -rf ~/.vim/bundle/vundle && git clone http://github.com/mduan/vundle.git ~/.vim/bundle/vundle/ && vim -c "silent BundleInstall" -c "silent helptags ~/.vim/bundle/vundle/doc" -c "silent qa!" && cd ~/.vim/bundle/Command-T/ruby/command-t && ruby extconf.rb && make && cd -'

sudo apt-get install --force-yes --yes autojump
#sh -c 'rm -rf /tmp/git_autojump/ && cd /tmp && wget https://github.com/downloads/joelthelion/autojump/autojump_v20.tar.gz && cd /tmp/autojump_v20 && chmod a+x install.sh && ./install.sh --local --zsh'

sudo apt-get install --force-yes --yes python-pip python-dev
sudo pip install virtualenv virtualenvwrapper

# any additional packages that might be worth installing
#sudo apt-get install vim-gnome; # contains more extensions than vim package (i.e. clipboard support)
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
