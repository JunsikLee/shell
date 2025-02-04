#!/bin/bash
# 우분투에서 zsh, oh-my-zsh, 테마 변경, 주요 플러그인 설치 스크립트

# 1. 시스템 업데이트 및 필수 패키지 설치 (zsh, curl, git)
echo "시스템 업데이트 및 필수 패키지(zsh, curl, git) 설치 중..."
sudo apt update && sudo apt install -y zsh curl git

# 2. zsh 설치 확인
if ! command -v zsh >/dev/null 2>&1; then
  echo "zsh 설치에 실패했습니다. 스크립트를 종료합니다."
  exit 1
fi

# 3. 현재 사용자의 기본 쉘을 zsh로 변경
echo "기본 쉘을 zsh로 변경합니다..."
chsh -s "$(which zsh)"

# 4. oh-my-zsh 설치 (자동 설치 스크립트 실행)
# 설치 과정 중 zsh 실행을 자동으로 시작하지 않도록 환경변수를 설정합니다.
export RUNZSH=no
export CHSH=no

echo "oh-my-zsh 설치 중..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# 5. oh-my-zsh 기본 테마 변경 (예: 'agnoster'로 변경)
echo "oh-my-zsh 테마를 'agnoster'로 변경합니다..."
sed -i 's/^ZSH_THEME=".*"/ZSH_THEME="agnoster"/' ~/.zshrc

# 6. 주요 플러그인 설치: zsh-autosuggestions, zsh-syntax-highlighting
echo "주요 zsh 플러그인(zsh-autosuggestions, zsh-syntax-highlighting) 설치 중..."
# oh-my-zsh 사용자 정의 디렉토리 설정 (없으면 기본값 사용)
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

# 플러그인 저장소 클론
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting

# 7. .zshrc 파일의 plugins 배열에 위 플러그인 추가
# 기존 plugins 라인에 두 플러그인이 포함되어 있지 않다면 추가합니다.
if grep -q "plugins=(.*zsh-autosuggestions" ~/.zshrc && grep -q "plugins=(.*zsh-syntax-highlighting" ~/.zshrc; then
  echo "플러그인이 이미 설정되어 있습니다."
else
  echo "플러그인을 .zshrc에 추가합니다..."
  # plugins 배열의 마지막에 두 플러그인을 추가 (기존 내용 뒤에 덧붙임)
  sed -i 's/^plugins=(\(.*\))/plugins=(\1 zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc
fi

echo "설치 및 설정 완료!"
echo "변경 사항을 적용하려면 터미널을 재시작하거나 새 세션을 시작하세요."
