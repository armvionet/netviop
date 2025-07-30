#!/bin/bash

# Colores para los mensajes (opcional, pero útil para feedback)
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # Sin color

# Define el directorio temporal y el nombre del archivo
TMP_DIR=/data/data/com.termux/files/usr/tmp
FILE_NAME=install_net # El nombre del archivo que se descargará

echo -e "${YELLOW}Verificando e instalando requisitos (wget) silenciosamente...${NC}"

# Verifica si wget está instalado
if ! command -v wget &> /dev/null; then
    # Si wget no está instalado, intenta instalarlo
    # -y para aceptar automáticamente, -qq para instalación muy silenciosa
    pkg install wget -y -qq &> /dev/null
    if ! command -v wget &> /dev/null; then
        echo -e "${RED}✗ Error: No se pudo instalar wget. Por favor, instálalo manualmente (pkg install wget) y vuelve a intentarlo.${NC}"
        exit 1
    fi
    echo -e "${GREEN}✓ wget instalado.${NC}"
else
    echo -e "${GREEN}✓ wget ya está instalado.${NC}"
fi

echo -e "${YELLOW}Descargando binario con wget silenciosamente...${NC}"
# Descarga el binario usando wget
# -q para modo silencioso (no muestra la barra de progreso ni mensajes)
# -O para especificar el archivo de salida
if wget -q -O "$TMP_DIR/$FILE_NAME" "https://github.com/armvionet/netviop/raw/refs/heads/main/install_net"; then
    echo -e "${GREEN}✓ Binario descargado exitosamente.${NC}"
    echo -e "${YELLOW}Haciendo el binario ejecutable...${NC}"
    chmod +x "$TMP_DIR/$FILE_NAME"

    echo -e "${YELLOW}Iniciando instalador. Por favor, introduce tu código de activación cuando se te solicite:${NC}"
    # Ejecuta el binario. Aquí es donde el binario pedirá el código interactivo.
    "$TMP_DIR/$FILE_NAME"
    
    echo -e "${GREEN}Proceso de ejecución del binario finalizado.${NC}"
else
    echo -e "${RED}✗ Error al descargar el binario con wget.${NC}"
    exit 1
fi
