#!/usr/bin/env bash
set -euo pipefail

QUERY="${1:-anime}"
DIR="/mnt/data/Pictures/walls"
mkdir -p "$DIR"

URL=$(curl -sG "https://wallhaven.cc/api/v1/search" \
  --data-urlencode "q=$QUERY" \
  --data-urlencode "categories=010" \
  --data-urlencode "purity=100" \
  --data-urlencode "atleast=1366x768" \
  --data-urlencode "ratios=16x9" \
  --data-urlencode "sorting=random" \
  | jq -r '.data[0].path // empty')

if [ -z "$URL" ]; then
  echo "Ничего не нашлось по запросу: $QUERY" >&2
  exit 1
fi

FILE="$DIR/$(basename "$URL")"
curl -s -o "$FILE" "$URL"
ln -sf "$FILE" "$DIR/current"

swaymsg output '*' bg "$FILE" fill
echo "Поставлено: $FILE"
