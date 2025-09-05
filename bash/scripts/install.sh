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
  git sparse-checkout set --no-cone bash helix vim tmux local && \
  git checkout
  mv /tmp/dotfiles /tmp/dotfiles-main
else
  wget -q --show-progress "https://github.com/evantaur/dotfiles/archive/refs/heads/main.tar.gz" -O /tmp/dotfiles.tar.gz && \
  cd /tmp/ && \
  tar xf dotfiles.tar.gz
fi && \
[[ -d "$HOME/.local/bin" ]] || mkdir -p "$HOME/.local/bin" && \
[[ -d "$HOME/.local/share/man" ]] || mkdir -p "$HOME/.local/share/man" && \
cp -r /tmp/dotfiles-main/bash    $HOME/.config/ && \
cp -r /tmp/dotfiles-main/helix   $HOME/.config/ && \
cp -r /tmp/dotfiles-main/vim     $HOME/.config/ && \
cp -r /tmp/dotfiles-main/tmux    $HOME/.config/ && \
cp -r /tmp/dotfiles-main/local/* $HOME/.local/ && \
[[ -e $HOME/.bashrc && ! -L $HOME/.bashrc ]] && mv $HOME/.bashrc $HOME/._backup_bashrc
[[ -e $HOME/.vimrc && ! -L $HOME/.vimrc ]] && mv $HOME/.vimrc $HOME/._backup_vimrc
cd $HOME
[[ -e ~/.bashrc ]] || ln -s $HOME/.config/bash/bashrc ~/.bashrc
[[ -e ~/.vimrc ]] || ln -s $HOME/.config/vim/vimrc ~/.vimrc
[[ -e ~/.vim ]] || ln -s $HOME/.config/vim/vim ~/.vim

check_if_installed() {
  # Check if installed via package manager
  [[ "$(command -v $1)" == "" ]] || \
  [[ "$(command -v $1)" == *"$HOME"* ]] && \
    echo -n false || echo -n true
}

get_dirname() {
  echo "$1" | sed -E 's/\.tar\.gz$|\.tar$|\.zip$//'

}

download_stuff() {
  # Placeholder but will do for now

  cd /tmp/
  # Install Gum
  [[ "$(check_if_installed gum)" == true ]] || ( \
    echo "Installing Gum"
    GH_URL="$(get_github_release charmbracelet/gum)"
    GH_FILE="$(basename -- $GH_URL)"
    GH_DIR="/tmp/$(get_dirname $GH_FILE)"
    
    wget -q --show-progress "$GH_URL" -O "/tmp/$GH_FILE" && \
    tar xf "/tmp/$GH_FILE" && \
    cp "$GH_DIR/gum" "$HOME/.local/bin/" && \
    cp "$GH_DIR/completions/gum.bash" "$HOME/.config/bash/completitions/" && \
    cp "$GH_DIR/manpages/"* "$HOME/.local/share/man/" && \
    rm -r "$GH_DIR" && \
    rm "/tmp/$GH_FILE" && \
    echo "Gum Installed" || echo "Gum installation failed"
  )

  # Install Shmarks
  [[ "$(check_if_installed shmarks)" == true ]] || ( \
    echo "Installing Shmarks"
    GH_URL="$(get_github_release ybda/shmarks)"
    GH_FILE="$(basename -- $GH_URL)"
    GH_DIR="/tmp/$(get_dirname $GH_FILE)"
    
    wget -q --show-progress "$GH_URL" -O "/tmp/$GH_FILE" && \
    tar xf /tmp/$GH_FILE && \
    cp "$GH_DIR/shmarks" "$HOME/.local/bin/" && \
    rm -r "$GH_DIR" && \
    rm "/tmp/$GH_FILE" && \
    echo "SHmarks Installed" || echo "SHmarks installation failed"
  )
#   # Install Numbat
  [[ "$(check_if_installed numbat)" == true ]] || ( \
    echo "Installing Numbat"
    GH_URL="$(get_github_release sharkdp/numbat)"
    GH_FILE="$(basename -- $GH_URL)"
    GH_DIR="/tmp/$(get_dirname $GH_FILE)"
    
    wget -q --show-progress "$GH_URL" -O "/tmp/$GH_FILE" && \
    tar xf /tmp/$GH_FILE && \
    cp "$GH_DIR/numbat" "$HOME/.local/bin/" && \
    rm -r "$GH_DIR" && \
    rm "/tmp/$GH_FILE" && \
    echo "Numbat Installed" || echo "Numbat installation failed"
  )


  
}

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

download_stuff
rm -rf /tmp/dotfiles-main
[[ -e "/tmp/dotfiles.tar.gz" ]] && rm /tmp/dotfiles.tar.gz
source ~/.bashrc


