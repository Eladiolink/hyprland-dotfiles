#!/bin/bash

# mensagens aleatórias quando nada está tocando
messages=(
    "Nada tocando 🎵"
    "Música parada 🛑"
    "Aproveite o silêncio 🤫"
    "Hora de relaxar 😌"
    "Sua playlist está vazia 😢"
)

# ícones por player
declare -A player_icons
player_icons=(
    ["chromium"]=""
    ["firefox"]=""
    ["kdeconnect"]=""
    ["mopidy"]=""
    ["mpv"]="󰐹"
    ["spotify"]=""
    ["vlc"]="󰕼"
    ["default"]=""
)

while true; do
    # tenta pegar o player ativo
    player=$(playerctl -l 2>/dev/null | head -n 1)
    
    if [ -z "$player" ]; then
        # nenhum player tocando
        index=$(( RANDOM % ${#messages[@]} ))
        echo "${player_icons["default"]} ${messages[$index]}"
    else
        # se houver player, pega título e artista
        title=$(playerctl --player="$player" metadata --format '{{title}}' 2>/dev/null)
        artist=$(playerctl --player="$player" metadata --format '{{artist}}' 2>/dev/null)
        icon=${player_icons["$player"]}
        [ -z "$icon" ] && icon=${player_icons["default"]}
        echo "$icon $title - $artist"
    fi

    sleep 5
done
