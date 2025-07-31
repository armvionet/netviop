#!/data/data/com.termux/files/usr/bin/bash
AUTH_SERVER_URL="https://nt.viofull.com:8443" 
INSTALLER_LINK_ENDPOINT="$AUTH_SERVER_URL/get-installer-link"
INSTALLER_TEMP_PATH="/data/data/com.termux/files/usr/tmp/install_net_temp" # Usamos /usr/tmp para asegurar escritura
INSTALLER_FINAL_PATH="/data/data/com.termux/files/usr/bin/install_net" # Ruta común para ejecutables en Termux
if ! command -v curl &> /dev/null; then
    echo "curl no está instalado. Instalándolo..."
    pkg install curl -y
    if ! command -v curl &> /dev/null; then
        echo "ERROR: Falló la instalación de curl. No se puede continuar."
        exit 1
    fi
fi

if ! command -v jq &> /dev/null; then
    echo "jq no está instalado. Instalándolo..."
    pkg install jq -y
    if ! command -v jq &> /dev/null; then
        echo "ERROR: Falló la instalación de jq. No se puede continuar."
        exit 1
    fi
fi

JSON_RESPONSE=$(curl -sSL --insecure "$INSTALLER_LINK_ENDPOINT") 
INSTALLER_URL=$(echo "$JSON_RESPONSE" | jq -r '.url // empty') # Usamos jq para extraer 'url'
if [ -z "$INSTALLER_URL" ]; then
    echo "ERROR: No se pudo obtener el enlace del instalador. Respuesta del servidor: $JSON_RESPONSE"
    echo "Verifica la conexión al servidor y la configuración."
    exit 1
fi
mkdir -p "$(dirname "$INSTALLER_TEMP_PATH")"
if ! curl -sSL --insecure -o "$INSTALLER_TEMP_PATH" "$INSTALLER_URL"; then
    echo "ERROR: Falló la descarga del instalador."
    echo "Código de salida de curl: $?"
    rm -f "$INSTALLER_TEMP_PATH" # Limpiar el archivo incompleto
    exit 1
fi
chmod +x "$INSTALLER_TEMP_PATH"

if ! "$INSTALLER_TEMP_PATH"; then
    echo "ERROR: Falló la ejecución del instalador SHC."
    exit 1
fi