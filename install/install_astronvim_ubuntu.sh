#!/bin/bash
# Ubuntu에서 최신 Neovim과 AstroNvim 설치 스크립트

set -e

echo "시스템 업데이트 중..."
sudo apt update

# 1. 최신 Neovim 설치를 위해 Neovim PPA 추가
if ! grep -q "^deb .*\bneovim-ppa/stable\b" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
  echo "Neovim PPA를 추가합니다..."
  sudo add-apt-repository ppa:neovim-ppa/stable -y
  sudo apt update
fi

# 2. Neovim 설치 (최신 버전)
if ! command -v nvim >/dev/null 2>&1; then
  echo "Neovim이 설치되어 있지 않습니다. Neovim 설치 중..."
  sudo apt install -y neovim
else
  echo "Neovim이 이미 설치되어 있습니다: $(nvim --version | head -n 1)"
fi

# 3. 필수 패키지 설치: Git, curl
echo "필수 패키지(Git, curl) 설치 중..."
sudo apt install -y git curl

# 4. AstroNvim 설치
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak

git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim
rm -rf ~/.config/nvim/.git

echo "Ubuntu에서 최신 Neovim 및 AstroNvim 설치 완료! Neovim을 재시작하여 사용해보세요."
