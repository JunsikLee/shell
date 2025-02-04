#!/bin/bash
# Rocky Linux에서 최신 Neovim과 AstroNvim 설치 스크립트 (Neovim tarball URL 업데이트)

set -e

echo "시스템 업데이트 중..."
sudo dnf update -y

# 1. Neovim 최신 버전 설치 (GitHub 최신 tarball 사용)
if ! command -v nvim >/dev/null 2>&1; then
  echo "Neovim이 설치되어 있지 않습니다. 최신 Neovim 설치 중..."
else
  echo "현재 설치된 Neovim 버전: $(nvim --version | head -n 1)"
fi

# 최신 Neovim tarball 다운로드 (안정 버전, 새 URL 사용)
echo "최신 Neovim tarball을 다운로드합니다..."
curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz

# 기존 Neovim이 설치되어 있더라도 최신 버전으로 덮어쓰도록 진행합니다.
echo "다운로드한 tarball을 /usr/local에 압축 해제하여 최신 Neovim 설치..."
sudo tar xzf nvim-linux-x86_64.tar.gz -C /usr/local --strip-components=1

# 다운로드 파일 삭제
rm -f nvim-linux-x86_64.tar.gz

# 2. 필수 패키지 설치: Git, curl (이미 curl 설치되어 있으나 git 확인)
echo "필수 패키지(Git, curl) 설치 중..."
sudo dnf install -y git curl

# 3. AstroNvim 설치
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak

git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim
rm -rf ~/.config/nvim/.git

echo "Rocky Linux에서 최신 Neovim 및 AstroNvim 설치 완료! Neovim을 재시작하여 사용해보세요."
