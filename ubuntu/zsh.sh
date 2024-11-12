#!/bin/bash

# 패키지 리스트 업데이트 및 zsh 설치
apt update
apt install zsh git curl -y

# Oh My Zsh 설치 (자동 실행 및 .zshrc 덮어쓰기 방지)
export RUNZSH=no
export KEEP_ZSHRC=yes
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# zsh-autosuggestions 플러그인 설치
git clone https://github.com/zsh-users/zsh-autosuggestions \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# zsh-syntax-highlighting 플러그인 설치
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# powerlevel10k 테마 설치
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

# 기존 .zshrc 백업
cp ~/.zshrc ~/.zshrc.backup

# 테마를 powerlevel10k로 설정
sed -i 's/ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

# 플러그인 활성화
sed -i 's/plugins=(.*)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc

# 기본 쉘을 zsh로 변경
chsh -s $(which zsh)

echo "설치가 완료되었습니다! 변경 사항을 적용하려면 로그아웃 후 다시 로그인하세요."
