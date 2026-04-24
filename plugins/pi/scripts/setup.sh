#!/usr/bin/env bash
set -euo pipefail

# pi-plugin-cc setup: pi 설치 확인 및 초기 설정
# /pi:setup에서 호출됨

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PLUGIN_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "[pi-plugin] Running setup..."

# 1. pi 바이너리 확인
if command -v pi >/dev/null 2>&1; then
  echo "[pi-plugin] ✓ pi installed ($(pi --version 2>/dev/null || echo 'unknown'))"
else
  echo "[pi-plugin] ✗ pi not found"
  echo "[pi-plugin]   Install: npm i -g @mariozechner/pi-coding-agent"
  echo "[pi-plugin]   Requires: Node.js >= 20.6.0"
fi

# 2. pi-cc 실행 권한 확인
if [[ -x "$PLUGIN_DIR/bin/pi-cc" ]]; then
  echo "[pi-plugin] ✓ pi-cc ready"
else
  chmod +x "$PLUGIN_DIR/bin/pi-cc" 2>/dev/null && echo "[pi-plugin] ✓ pi-cc made executable" || echo "[pi-plugin] ⚠ Could not set pi-cc executable"
fi

# 3. hooks 실행 권한 확인
if [[ -f "$PLUGIN_DIR/hooks/pi-caller-inject.sh" ]]; then
  chmod +x "$PLUGIN_DIR/hooks/pi-caller-inject.sh" 2>/dev/null || true
  echo "[pi-plugin] ✓ hooks ready"
fi

# 4. 초기 usage 파일 생성
mkdir -p "$HOME/.pi-cc-tasks"
if [[ ! -f "$HOME/.pi-cc-tasks/.usage.json" ]]; then
  echo '{"input":0,"output":0,"totalTokens":0,"tasks":0,"cost":0.0,"lastTps":0,"totalDuration":0,"lastTtft":0,"ttftSum":0,"ttftCount":0,"avgTtft":0}' > "$HOME/.pi-cc-tasks/.usage.json"
  echo "[pi-plugin] ✓ Usage file initialized"
else
  echo "[pi-plugin] ✓ Usage file exists"
fi

echo ""
echo "[pi-plugin] Setup complete."
