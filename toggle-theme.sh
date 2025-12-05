#!/bin/bash

# 定义样式文件路径
CONFIG_DIR="$HOME/.config/waybar"
LIGHT_THEME="$CONFIG_DIR/style-light.css"
DARK_THEME="$CONFIG_DIR/style-dark.css"
CURRENT_STYLE="$CONFIG_DIR/style.css"

# 检查样式文件是否存在
if [ ! -f "$LIGHT_THEME" ] || [ ! -f "$DARK_THEME" ]; then
    echo "Error: Theme files ($LIGHT_THEME or $DARK_THEME) not found!"
    exit 1
fi

# 检查当前主题
if [ -f "$CURRENT_STYLE" ] && grep -q "background: rgba(255, 255, 255, 0.9)" "$CURRENT_STYLE"; then
    # 当前是亮色主题，切换到暗色
    cp "$DARK_THEME" "$CURRENT_STYLE"
    echo "Switched to dark theme"
else
    # 当前是暗色主题或文件不存在，切换到亮色
    cp "$LIGHT_THEME" "$CURRENT_STYLE"
    echo "Switched to light theme"
fi

# 确保 Waybar 进程被正确终止并重启
pkill -u "$USER" waybar
sleep 0.5  # 短暂延迟以确保进程完全终止
waybar -c "$CONFIG_DIR/config.jsonc" -s "$CONFIG_DIR/style.css" & disown

# 检查 Waybar 是否成功启动
if pgrep -u "$USER" waybar > /dev/null; then
    echo "Waybar restarted successfully"
else
    echo "Error: Waybar failed to restart"
    exit 1
fi

