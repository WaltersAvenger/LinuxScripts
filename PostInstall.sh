#!/bin/bash

# Customize terminal
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

# Installs all required software

# Update packages
sudo apt update
sudo apt upgrade -y
flatpak update -y

#Install NEOVIM
#https://github.com/neovim/neovim/blob/master/BUILD.md
sudo apt-get install ninja-build gettext cmake unzip curl build-essential
git clone https://github.com/neovim/neovim
cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo 
sudo make install 

#Lazy Vim
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

#Install wex term
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo apt update
sudo apt install wezterm


# Install software
sudo apt install gimp
sudo apt install tmux
# git clone https://github.com/tmux/tmux.git
#cd tmux
#sh autogen.sh
#./configure && make
