#!/bin/bash
#
# Downloads and installs bash config, probably 
# don't want to run this unless you're me...
#

# Create dirpath if it doesn't exist
[[ -z $HOME/.config/bash ]] || mkdir -p bash

# Use Git if found else try wget
if command -v git &> /dev/null ; then
  cd /tmp
  git clone -n --depth=1 --filter=tree:0 https://github.com/evantaur/dotfiles.git && \
  cd dotfiles && \
  git sparse-checkout set --no-cone bash helix && \
  git checkout
  mv /tmp/dotfiles /tmp/dotfiles-main
else
  wget --show-progress "https://github.com/evantaur/dotfiles/archive/refs/heads/main.tar.gz" -O /tmp/dotfiles.tar.gz && \
  cd /tmp/ && \
  tar xvf dotfiles.tar.gz
fi && \
cp -r /tmp/dotfiles-main/bash  $HOME/.config/ && \
cp -r /tmp/dotfiles-main/helix $HOME/.config/ && \
[[ -e $HOME/.bashrc && ! -L $HOME/.bashrc ]] && mv $HOME/.bashrc $HOME/._backup_bashrc
cd $HOME
[[ -e ~/.bashrc ]] || ln -s $HOME/.config/bash/bashrc ~/.bashrc
rm -rf /tmp/dotfiles-main
[[ -e "/tmp/dotfiles.tar.gz" ]] && rm /tmp/dotfiles.tar.gz
source ~/.bashrc


