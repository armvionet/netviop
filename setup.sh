#!/data/data/com.termux/files/usr/bin/bash
#viotonic
AUTH_SERVER_URL="https://nt.viofull.com:8443" # O la IP/dominio de tu servidor

INSTALLER_LINK_ENDPOINT="$AUTH_SERVER_URL/get-installer-link"
INSTALLER_TEMP_PATH="/data/data/com.termux/files/usr/tmp/install_net_temp" # Usamos /usr/tmp para asegurar escritura
INSTALLER_FINAL_PATH="/data/data/com.termux/files/usr/bin/install_net" # Ruta común para ejecutables en Termux

INSTALLER_URL=$(wget -qO- "$INSTALLER_LINK_ENDPOINT" | grep -oP '"url": "\K[^"]*')

if [ -z "$INSTALLER_URL" ]; then
    echo "ERROR: No se pudo obtener el enlace del instalador. Verifica la conexión al servidor y la configuración."
    exit 1
fi

mkdir -p "$(dirname "$INSTALLER_TEMP_PATH")"

if ! wget -q --show-progress -O "$INSTALLER_TEMP_PATH" "$INSTALLER_URL"; then
    echo "ERROR: Falló la descarga del instalador."
    rm -f "$INSTALLER_TEMP_PATH" 
    exit 1
fi
chmod +x "$INSTALLER_TEMP_PATH"


if ! "$INSTALLER_TEMP_PATH"; then
    echo "ERROR: Falló la ejecución del instalador."
    exit 1
fi
