#!/bin/bash

# Configuración
API_KEY="${API_KEY}"  # Utiliza el secreto API_KEY configurado en GitHub
CIUDAD="${CIUDAD}"    # Utiliza el secreto CIUDAD configurado en GitHub
URL="https://api.openweathermap.org/data/2.5/weather?q=$CIUDAD&units=metric&APPID=$API_KEY&lang=es"

# IDs de sensores según el fenómeno
ID_TEMP="6863e51fa17d510007ee781e"
ID_HUMEDAD="6863e51fa17d510007ee781f"
ID_VIENTO="6863e51fa17d510007ee7820"
ID_PRESION="6863e51fa17d510007ee7821"

# Obtener datos
RESPUESTA=$(curl -s "$URL")
TEMP=$(echo "$RESPUESTA" | jq '.main.temp?')
HUMEDAD=$(echo "$RESPUESTA" | jq '.main.humidity?')
PRESION=$(echo "$RESPUESTA" | jq '.main.pressure?')
VIENTO=$(echo "$RESPUESTA" | jq '.wind.speed?')

# Fecha en formato ISO 8601 con "Z" (UTC)
FECHA=$(date -u '+%Y-%m-%dT%H:%M:%SZ')

# Imprimir formato para senseBox (una línea por sensor)
echo "$ID_TEMP,$TEMP,$FECHA"
echo "$ID_HUMEDAD,$HUMEDAD,$FECHA"
echo "$ID_VIENTO,$VIENTO,$FECHA"
echo "$ID_PRESION,$PRESION,$FECHA"


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

