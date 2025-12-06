$ErrorActionPreference = "Stop"

New-Item -ItemType Directory -Force -Path "artifacts" | Out-Null
$logFile = "artifacts\windows-log.txt"

"[INFO] Inicio del script Windows" | Tee-Object -FilePath $logFile

# Leer archivo si existe
if (Test-Path "README.md") {
    "[INFO] Leyendo README.md" | Tee-Object -FilePath $logFile -Append
    Get-Content "README.md" -TotalCount 5 | Tee-Object -FilePath $logFile -Append
} else {
    "[WARN] README.md no existe" | Tee-Object -FilePath $logFile -Append
}

# Escribir archivo de salida
"[INFO] Escribiendo archivo de salida" | Tee-Object -FilePath $logFile -Append
"Salida generada en Windows a $(Get-Date)" | Out-File -FilePath "artifacts\output-windows.txt" -Encoding utf8

# Gestión de permisos con icacls
"[INFO] Gestionando permisos con icacls" | Tee-Object -FilePath $logFile -Append
icacls "artifacts\output-windows.txt" | Tee-Object -FilePath $logFile -Append

# Proceso en segundo plano
"[INFO] Lanzando proceso en segundo plano" | Tee-Object -FilePath $logFile -Append
Start-Process -FilePath "powershell" -ArgumentList "-Command `"Start-Sleep -Seconds 10; Add-Content -Path `"$logFile`" -Value 'Tarea en background completada'`""

# Variables de entorno
"[INFO] NORMAL_ENV=$env:NORMAL_ENV" | Tee-Object -FilePath $logFile -Append

if ($env:MY_SECRET) {
    "[INFO] Se recibió secreto MY_SECRET (no se muestra por seguridad)" | Tee-Object -FilePath $logFile -Append
} else {
    "[ERROR] No se recibió MY_SECRET" | Tee-Object -FilePath $logFile -Append
    exit 1    # Código de salida != 0 -> falla el job
}

"[INFO] Script Windows completado correctamente" | Tee-Object -FilePath $logFile -Append
exit 0
