#!/bin/bash
#
# Downloads and installs bash config, probably 
# don't want to run this unless you're me...
#

LANG=en_US.UTF-8
LC_ALL=en_US.UTF-8

# Create dirpath if it doesn't exist
[[ -z $HOME/.config/bash ]] || mkdir -p $HOME/.config/bash

# Use Git if found else try wget
if command -v git &> /dev/null ; then
  cd /tmp
  git clone -n --depth=1 --filter=tree:0 https://github.com/evantaur/dotfiles.git && \
  cd dotfiles && \
  git sparse-checkout set --no-cone bash helix vim && \
  git checkout
  mv /tmp/dotfiles /tmp/dotfiles-main
else
  wget --show-progress "https://github.com/evantaur/dotfiles/archive/refs/heads/main.tar.gz" -O /tmp/dotfiles.tar.gz && \
  cd /tmp/ && \
  tar xvf dotfiles.tar.gz
fi && \
cp -r /tmp/dotfiles-main/bash  $HOME/.config/ && \
cp -r /tmp/dotfiles-main/helix $HOME/.config/ && \
cp -r /tmp/dotfiles-main/vim   $HOME/.config/ && \
[[ -e $HOME/.bashrc && ! -L $HOME/.bashrc ]] && mv $HOME/.bashrc $HOME/._backup_bashrc
[[ -e $HOME/.vimrc && ! -L $HOME/.vimrc ]] && mv $HOME/.vimrc $HOME/._backup_vimrc
cd $HOME
[[ -e ~/.bashrc ]] || ln -s $HOME/.config/bash/bashrc ~/.bashrc
[[ -e ~/.vimrc ]] || ln -s $HOME/.config/vim/vimrc ~/.vimrc
[[ -e ~/.vim ]] || ln -s $HOME/.config/vim/vim ~/.vim


random_emoji(){
    # Unicode emoji ranges (Hexadecimal)
    ranges=(
        #"1F600 1F64F"  # Emoticons
        "1F300 1F5FF"  # Misc symbols & pictographs
        #"1F680 1F6FF"  # Transport & map
        "1F900 1F9FF"  # Supplemental symbols & pictographs
        #"1FA70 1FAFF"  # Symbols & pictographs extended
    )


    # Pick a random range
    range_index=$((RANDOM % ${#ranges[@]}))
    range=(${ranges[$range_index]})

    # Pick a random codepoint in the selected range
    random_code=$(( (0x${range[0]}) + RANDOM % ( (0x${range[1]}) - (0x${range[0]}) ) ))

    # Convert and print emoji
    printf "\U$(printf "%X" $random_code)\n"

}

# Function to generate a random color, ensuring it's not too dark
generate_color() {
    min_brightness=10  # Adjust this for brightness (0-255)

    # Generate R, G, B values ensuring they're above the threshold
    R=$(( RANDOM % (256 - min_brightness) + min_brightness ))
    G=$(( RANDOM % (256 - min_brightness) + min_brightness ))
    B=$(( RANDOM % (256 - min_brightness) + min_brightness ))

    # Convert to HEX
    printf "#%02X%02X%02X\n" "$R" "$G" "$B"
}


# Man the hostcolor and host icon if not present
[[ -f ~/.config/bash/.hostcolor ]] || generate_color > $HOME/.config/bash/.hostcolor
[[ -f ~/.config/bash/.hosticon ]] || random_emoji > $HOME/.config/bash/.hosticon


rm -rf /tmp/dotfiles-main
[[ -e "/tmp/dotfiles.tar.gz" ]] && rm /tmp/dotfiles.tar.gz
source ~/.bashrc


