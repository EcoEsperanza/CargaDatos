#!/bin/bash

# Si hay retornos de carro (\r), eliminarlos (por si acaso)
# Esto solo corrige líneas que aún lo tengan; no sustituye guardarlo limpio
sed -i 's/\r$//' "$0"

# Configuración desde entorno (variables configuradas en GitHub Actions)
API_KEY="${API_KEY}"
CIUDAD="${CIUDAD}"
# Opcional: codificar caracteres especiales (tilde, espacios) en ciudad
CIUDAD_ENCODED=$(echo "$CIUDAD" | sed 's/ /%20/g; s/á/a/g; s/é/e/g; s/í/i/g; s/ó/o/g; s/ú/u/g; s/Á/A/g; s/É/E/g; s/Í/I/g; s/Ó/O/g; s/Ú/U/g')
URL="https://api.openweathermap.org/data/2.5/weather?q=${CIUDAD_ENCODED}&units=metric&APPID=${API_KEY}&lang=es"

# IDs de sensores
ID_TEMP="6863e51fa17d510007ee781e"
ID_HUMEDAD="6863e51fa17d510007ee781f"
ID_VIENTO="6863e51fa17d510007ee7820"
ID_PRESION="6863e51fa17d510007ee7821"

# Obtener datos
RESPUESTA=$(curl -s "$URL")

# Debug: ver lo que responde la API (para ayudar a diagnosticar)
echo "Respuesta cruda: $RESPUESTA" >&2

# Extraer valores con jq; usar “?” para que si el campo no existe devuelva null en lugar de error
TEMP=$(echo "$RESPUESTA" | jq '.main.temp?')
HUMEDAD=$(echo "$RESPUESTA" | jq '.main.humidity?')
PRESION=$(echo "$RESPUESTA" | jq '.main.pressure?')
VIENTO=$(echo "$RESPUESTA" | jq '.wind.speed?')

# Fecha en UTC ISO 8601
FECHA=$(date -u '+%Y-%m-%dT%H:%M:%SZ')

# Imprimir cada sensor en una línea esperada
echo "$ID_TEMP,$TEMP,$FECHA"
echo "$ID_HUMEDAD,$HUMEDAD,$FECHA"
echo "$ID_VIENTO,$VIENTO,$FECHA"
echo "$ID_PRESION,$PRESION,$FECHA"
