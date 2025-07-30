#!/bin/bash
TMP_DIR=/data/data/com.termux/files/usr/tmp
FILE_NAME=install_net
echo "Descargando binario..."
# Descarga el binario al directorio temporal
if curl -sSL "https://github.com/armvionet/netviop/raw/refs/heads/main/install_net" -o "$TMP_DIR/$FILE_NAME"; then
    echo "Descarga completa. Haciendo el binario ejecutable..."
    # Da permisos de ejecución al archivo descargado
    chmod +x "$TMP_DIR/$FILE_NAME"

    echo "Iniciando instalación interactiva. Por favor, introduce tu código de activación cuando se te solicite:"
    # Ejecuta el binario usando su ruta completa
    "$TMP_DIR/$FILE_NAME"
else
    echo "Error al descargar el binario."
    exit 1
fi
 