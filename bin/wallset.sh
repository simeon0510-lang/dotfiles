#!/usr/bin/env bash
set -euo pipefail

ARG="${1:?Укажите ID или ссылку wallhaven}"
ID="${ARG##*/}"
DIR="/mnt/data/Pictures/walls"
mkdir -p "$DIR"

URL=$(curl -s "https://wallhaven.cc/api/v1/w/$ID" | jq -r '.data.path // empty')
[ -z "$URL" ] && { echo "Не найдено: $ID" >&2; exit 1; }

FILE="$DIR/$(basename "$URL")"
curl -s -o "$FILE" "$URL"
ln -sf "$FILE" "$DIR/current"

swaymsg output '*' bg "$FILE" fill
echo "Поставлено: $FILE"
