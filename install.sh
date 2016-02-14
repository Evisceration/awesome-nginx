#!/bin/bash

source ./config.sh

cd ${CORE_DIR}

echo "[!] Installing"
echo "    (based on your configuration you may need to run this script as root)"
echo ""

make install


echo "[+] Done!"
echo ""

cd ${BASE_DIR}
