STATE_FILE="$HOME/.cache/niri_mode"
DEFAULT_STATE="tiled" # 初始状态

if [[ ! -f "$STATE_FILE" ]]; then
  echo "$DEFAULT_STATE" > "$STATE_FILE"
fi

STATE=$(cat "$STATE_FILE")

if [[ "$STATE" == "tiled" ]]; then
  ICON="●"
else
  ICON="○"
fi

echo "{\"text\": \"$ICON\", \"tooltip\": \"Current layout: $STATE\"}"

