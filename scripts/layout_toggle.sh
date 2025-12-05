#!/bin/bash

STATE_FILE="$HOME/.cache/niri_mode"
CURRENT=$(cat "$STATE_FILE" 2>/dev/null)

if [[ "$CURRENT" == "tiled" ]]; then
  echo "floating" > "$STATE_FILE"
  niri msg action toggle-floating # 你自己定义的动作
else
  echo "tiled" > "$STATE_FILE"
  niri msg action toggle-tiling # 你自己定义的动作
fi

