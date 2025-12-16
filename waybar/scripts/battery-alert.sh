#!/bin/bash

# Pega o caminho da bateria (normalmente BAT0)
BAT=$(upower -e | grep BAT)

# Lê o percentual
PERCENT=$(upower -i "$BAT" | grep percentage | awk '{print $2}' | sed 's/%//')

# Se estiver abaixo de 15% e não estiver carregando, avisa
STATUS=$(upower -i "$BAT" | grep state | awk '{print $2}')

if [ "$PERCENT" -le 20 ] && [ "$STATUS" = "discharging" ]; then
    dunstify -u critical -t 10000 "⚠ Bateria fraca" "Restam apenas $PERCENT%. Conecte o carregador!"
fi

