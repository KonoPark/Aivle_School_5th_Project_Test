#!/bin/bash
set -e

# 프론트(pm2)
if command -v pm2 >/dev/null 2>&1; then
  pm2 stop aivle-frontend || true
  pm2 delete aivle-frontend || true
fi

# 백엔드(jar)
pkill -f "book-.*\.jar" || true