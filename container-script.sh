#!/bin/sh

echo "=== Dentro del contenedor ==="
echo "APP_MESSAGE: $APP_MESSAGE"

# Directorio donde se montará el volumen desde el host
mkdir -p /app/output

echo "Mensaje generado desde el contenedor: $APP_MESSAGE" > /app/output/message.txt

echo "Archivo message.txt creado en /app/output"
sleep 5
