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

for d in kitty rofi fastfetch nvim btop cava niri swaylock yazi; do link_dir "$d"; done
for f in sway/config waybar/config.jsonc waybar/niri.jsonc waybar/style.css \
         waybar/clock.jsonc waybar/clock.css waybar/val.jsonc waybar/val.css \
         mako/config; do link_file "$f"; done

ln -sfn "$D/starship/starship.toml" "$C/starship.toml" && echo "ok: $C/starship.toml"
mkdir -p "$HOME/.bashrc.d" && ln -sfn "$D/bash/val.sh" "$HOME/.bashrc.d/val.sh" && echo "ok: ~/.bashrc.d/val.sh"

chmod +x "$D"/bin/*.sh 2>/dev/null || true
echo "Готово."
