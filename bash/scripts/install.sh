#!/bin/bash
#
# Downloads and installs bash config, probably 
# don't want to run this unless you're me...
#

# Create dirpath if it doesn't exist
[[ -z $HOME/.config/bash ]] || mkdir -p bash

wget --show-progress "https://github.com/evantaur/dotfiles/archive/refs/heads/main.tar.gz" -O /tmp/dotfiles.tar.gz && \
cd /tmp/ && \
tar xvf dotfiles.tar.gz && \
cp -r dotfiles-main/bash $HOME/.config/ && \
[[ -e $HOME/.bashrc ]] && mv $HOME/.bashrc $HOME/._backup_bashrc
cd $HOME
ln -s $HOME/.config/bash/bashrc ~/.bashrc && \
bash -l


