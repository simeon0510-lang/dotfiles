# Алиасы и gf из val-niri (у него zsh, здесь переписано под bash)

if command -v eza >/dev/null; then
    alias ls='eza --sort=modified --reverse --color=always --icons --git --group-directories-first'
    alias lc='ls -l'
    alias la='lc -A'
    alias lsa='lc -G'
fi
alias ff='fastfetch'

# Маленький кот с краткой сводкой
gf() {
    local k=$'\e[38;2;200;196;187m' v=$'\e[38;2;179;176;168m' c=$'\e[38;2;196;180;138m' r=$'\e[38;2;179;122;114m' n=$'\e[0m'
    local info=(
        "${k}Kernel  ${v}$(uname -r)"
        "${k} Shell  ${v}${SHELL}"
        "${k}  Disk  ${v}$(df -B1G --output=size,used / | awk 'NR==2 {print $2 " GiB | " $1 " GiB"}')"
        "${k}   Upt  ${v}$(uptime -p | sed 's/^up //')"
        "${k}  Host  ${v}$(hostname)"
    )
    local sprite=(
        "${c}   /\\_/\\  "
        "${c}  ( •⩊• ) "
        "${c}   > ${r}^ ${c}<  "
        "${c}  /|   |\\ "
        "${c} (_|   |_)"
    )
    echo
    for i in "${!info[@]}"; do
        printf '%s   %s%s\n' "${sprite[$i]}" "${info[$i]}" "$n"
    done
    echo
}
