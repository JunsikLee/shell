#!/bin/bash

# https://docs.astronvim.com/
# Optional Requirements:
# ripgrep - live grep telescope search (<Leader>fw)
# lazygit - git ui toggle terminal (<Leader>tl or <Leader>gg)
# go DiskUsage() - disk usage toggle terminal (<Leader>tu)
# bottom - process viewer toggle terminal (<Leader>tt)
# Python - python repl toggle terminal (<Leader>tp)
# Node - Node is needed for a lot of the LSPs, and for the node repl toggle terminal

# 1. nvim 설치
apt update
apt install -y software-properties-common
add-apt-repository ppa:neovim-ppa/stable
apt update
apt install -y neovim

# Optional Requirements

# ripgrep
apt-get install -y ripgrep

# lazygit
apt install -y curl
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
install lazygit -D -t /usr/local/bin/

# go
apt install -y golang

# Python3
apt instalsl -y python3 python3-pip

# Node.js
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash - 
apt-get install -y nodejs


# 설치 확인
echo "Neovim version: $(nvim --version | head -n 1)"
echo "ripgrep version: $(rg --version)"
echo "lazygit version: $(lazygit --version)"
echo "Go version: $(go version)"
echo "bottom version: $(btm --version)"
echo "Python version: $(python3 --version)"
echo "Node version: $(node --version)"

# astronvim 설치
mv ~/.config/nvim ~/.config/nvim.bak
git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim
rm -rf ~/.config/nvim/.git