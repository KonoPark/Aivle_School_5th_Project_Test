#!/bin/bash
set -e

APP_DIR="/opt/aivle-book-app"
FRONT_DIR="$APP_DIR/book/frontend"

# Node 런타임 설치는 AMI마다 다르니, 이미 설치되어 있다고 가정합니다.
# (미설치라면 EC2 UserData 또는 별도 provision 필요)

cd "$FRONT_DIR"

# 프로덕션 실행에 필요한 의존성 설치 (dev 제외)
npm ci --omit=dev

# pm2 설치(없으면)
if ! command -v pm2 >/dev/null 2>&1; then
  npm install -g pm2
fi