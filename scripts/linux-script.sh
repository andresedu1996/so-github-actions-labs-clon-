#!/usr/bin/env bash
set -euo pipefail

mkdir -p artifacts
LOG_FILE="artifacts/linux-log.txt"

echo "[INFO] Inicio del script Linux" | tee "$LOG_FILE"

# Leer archivo si existe
if [[ -f "README.md" ]]; then
  echo "[INFO] Leyendo README.md" | tee -a "$LOG_FILE"
  head -n 5 README.md >> "$LOG_FILE"
else
  echo "[WARN] README.md no existe" | tee -a "$LOG_FILE"
fi

# Escribir archivo de salida
echo "[INFO] Escribiendo archivo de salida" | tee -a "$LOG_FILE"
echo "Salida generada en Linux a las $(date)" > artifacts/output-linux.txt

# Gestión de permisos
echo "[INFO] Cambiando permisos con chmod" | tee -a "$LOG_FILE"
chmod 640 artifacts/output-linux.txt

# Proceso en segundo plano
echo "[INFO] Lanzando proceso en segundo plano" | tee -a "$LOG_FILE"
(
  sleep 10
  echo "Tarea en background completada" >> "$LOG_FILE"
) &

# Variables de entorno
echo "[INFO] NORMAL_ENV=$NORMAL_ENV" | tee -a "$LOG_FILE"
if [[ -n "${MY_SECRET:-}" ]]; then
  echo "[INFO] Se recibió secreto MY_SECRET (no se muestra por seguridad)" | tee -a "$LOG_FILE"
else
  echo "[ERROR] No se recibió MY_SECRET" | tee -a "$LOG_FILE"
  exit 1
fi

echo "[INFO] Script Linux completado correctamente" | tee -a "$LOG_FILE"
exit 0
