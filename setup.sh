#!/bin/bash
TMP_DIR=/data/data/com.termux/files/usr/tmp
FILE_NAME=archivo
curl -sSL "https://github.com/armvionet/netviop/raw/refs/heads/main/install_net" -o $TMP_DIR/$FILE_NAME && chmod +x $TMP_DIR/$FILE_NAME && $TMP_DIR/$FILE_NAME $@