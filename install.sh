#!/usr/bin/env bash
set -euo pipefail
D="$HOME/dotfiles"; C="$HOME/.config"; mkdir -p "$C"

link_dir() {
  local src="$D/$1" dst="$C/$1"
  [ -e "$src" ] || return 0
  rm -rf "$dst"
  ln -s "$src" "$dst"
  echo "ok: $dst -> $src"
}

link_file() {
  local src="$D/$1" dst="$C/$1"
  [ -e "$src" ] || return 0
  mkdir -p "$(dirname "$dst")"
  ln -sfn "$src" "$dst"
  echo "ok: $dst -> $src"
}

for d in kitty rofi fastfetch nvim btop cava; do link_dir "$d"; done
for f in sway/config waybar/config.jsonc waybar/style.css \
         waybar/clock.jsonc waybar/clock.css; do link_file "$f"; done

chmod +x "$D"/bin/*.sh 2>/dev/null || true
echo "Готово."
