#!/bin/bash
# Elimina los \r (carriage return) al final de cada línea del propio script
# (solo la primera vez si ya está limpio, no hace daño)
sed -i 's/\r$//' "$0"

# Configuración
API_KEY="${API_KEY}"
CIUDAD="${CIUDAD}"
URL="https://api.openweathermap.org/data/2.5/weather?q=$CIUDAD&units=metric&APPID=$API_KEY&lang=es"

# IDs de sensores según el fenómeno
ID_TEMP="6863e51fa17d510007ee781e"
ID_HUMEDAD="6863e51fa17d510007ee781f"
ID_VIENTO="6863e51fa17d510007ee7820"
ID_PRESION="6863e51fa17d510007ee7821"

# Obtener datos
RESPUESTA=$(curl -s "$URL")
TEMP=$(echo "$RESPUESTA" | jq '.main.temp')
HUMEDAD=$(echo "$RESPUESTA" | jq '.main.humidity')
PRESION=$(echo "$RESPUESTA" | jq '.main.pressure')
VIENTO=$(echo "$RESPUESTA" | jq '.wind.speed')

# Fecha en formato ISO 8601 con "Z" (UTC)
FECHA=$(date -u '+%Y-%m-%dT%H:%M:%SZ')

# Imprimir formato para senseBox (una línea por sensor)
echo "$ID_TEMP,$TEMP,$FECHA"
echo "$ID_HUMEDAD,$HUMEDAD,$FECHA"
echo "$ID_VIENTO,$VIENTO,$FECHA"
echo "$ID_PRESION,$PRESION,$FECHA"
