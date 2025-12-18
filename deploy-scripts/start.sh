#!/bin/bash
set -e

APP_DIR="/opt/aivle-book-app"
BACK_DIR="$APP_DIR/book"
FRONT_DIR="$APP_DIR/book/frontend"

JAR_PATH=$(ls -1 "$BACK_DIR"/build/libs/*.jar | head -n 1)

# 1) 백엔드 실행 (기본 8080)
nohup java -jar "$JAR_PATH" > /var/log/aivle-backend.log 2>&1 &

# 2) 프론트 실행 (기본 3000)
cd "$FRONT_DIR"
pm2 start npm --name aivle-frontend -- start
pm2 save

# 3) nginx는 프록시 역할이면 재시작(선택)
systemctl restart nginx || true