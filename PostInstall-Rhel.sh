#!/bin/bash

while getopts ":a:p:" opt; do
  case $opt in
  a)
    hostname="$OPTARG"
    ;;
  \?)
    echo "Invalid option -$OPTARG" >&2
    exit 1
    ;;
  esac

  case $OPTARG in
  -*)
    echo "Option $opt needs a valid argument"
    exit 1
    ;;
  esac
done

# Customize terminal
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

# Installs all required software

# Update packages
sudo dnf update
sudo dnf upgrade -y

#Install NEOVIM
#https://github.com/neovim/neovim/blob/master/BUILD.md
#sudo dnf install ninja-build gettext cmake unzip curl build-essential
#git clone https://github.com/neovim/neovim
#cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
#sudo make install
sudo dnf install neovim

#Lazy Vim
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

#Install wex term
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo dnf update
sudo dnf install wezterm

# Install software
sudo dnf install gimp
sudo dnf install tmux
# git clone https://github.com/tmux/tmux.git
#cd tmux
#sh autogen.sh
#./configure && make

# Add Docker's official GPG key:
sudo dnf update
sudo dnf install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
  sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
sudo dnf update

#Install  Docker
sudo dnf install docker

sudo yum update
sudo yum install docker-compose-plugin

#Install I3
sudo dnf install i3

hostnamectl set-hostname $hostname

#Install Ollama
curl -fsSL https://ollama.com/install.sh | sh

#enable ssh
systemctl enable sshd.servicesystemctl enable sshd.service

#docker ollama
#docker run -d --gpus=all -v ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama

#:docker exec -it ollama ollama run llama2

#FOR Ollama
curl -s -L https://nvidia.github.io/libnvidia-container/stable/rpm/nvidia-container-toolkit.repo |
  sudo tee /etc/yum.repos.d/nvidia-container-toolkit.repo
sudo dnf install -y nvidia-container-toolkit
