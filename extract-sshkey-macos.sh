#!/bin/bash
set -e
cd ~/.ssh
echo "Inserta tu YubiKey y toca el dispositivo cuando se te pida."
ssh-keygen -K
echo "Claves SSH extraídas desde la YubiKey."
# Descargar el fichero config personalizado
curl -fsSL https://raw.githubusercontent.com/Ismola/personal-ssh-config/main/config -o ~/.ssh/config
chmod 600 ~/.ssh/config
echo "Archivo de configuración SSH descargado y aplicado en ~/.ssh/config"
