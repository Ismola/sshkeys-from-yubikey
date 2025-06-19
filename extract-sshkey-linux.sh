#!/bin/bash
set -e
cd ~/.ssh
echo "Inserta tu YubiKey y toca el dispositivo cuando se te pida."
ssh-keygen -K
echo "Claves SSH extraídas desde la YubiKey."
# Descargar el fichero config personalizado usando git+ssh
TMPDIR=$(mktemp -d)
git clone --depth=1 --filter=blob:none --sparse git@github.com:Ismola/personal-ssh-config.git "$TMPDIR"
cd "$TMPDIR"
git sparse-checkout set config
cp config ~/.ssh/config
chmod 600 ~/.ssh/config
cd ~
rm -rf "$TMPDIR"
echo "Archivo de configuración SSH descargado y aplicado en ~/.ssh/config"
