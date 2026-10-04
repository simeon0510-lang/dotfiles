#!/usr/bin/env bash
# OSD громкости и яркости через mako (аналог dunstvol.sh/dunstback.sh из val-niri)
# osd.sh vol up|down|mute | mic | bright up|down
set -u
notify() { notify-send -a osd -h string:x-canonical-private-synchronous:osd -h "int:value:$2" "$1" "$3"; }

case "${1:-} ${2:-}" in
  "vol up")   wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+ ;;
  "vol down") wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- ;;
  "vol mute") wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle ;;
  "mic "*)    wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle ;;
  "bright up")   brightnessctl -q set 5%+ ;;
  "bright down") brightnessctl -q set 5%- ;;
esac

case "${1:-}" in
  vol)
    out=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
    v=$(awk '{print int($2*100+0.5)}' <<<"$out")
    if [[ $out == *MUTED* ]]; then notify "Громкость — выкл" "$v" "volume"; else notify "Громкость — $v%" "$v" "volume"; fi ;;
  mic)
    out=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)
    if [[ $out == *MUTED* ]]; then notify "Микрофон — выкл" 0 "mic"; else notify "Микрофон — вкл" 100 "mic"; fi ;;
  bright)
    v=$(( $(brightnessctl get) * 100 / $(brightnessctl max) ))
    notify "Яркость — $v%" "$v" "brightness" ;;
esac
