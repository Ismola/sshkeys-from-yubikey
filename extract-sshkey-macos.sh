#!/bin/bash
set -e
cd ~/.ssh
echo "Inserta tu YubiKey y toca el dispositivo cuando se te pida."
ssh-keygen -K
echo "Claves SSH extraídas desde la YubiKey."

# Detectar la clave privada recién extraída (la más reciente id_ed25519_sk*)
KEYFILE=$(ls -t id_ed25519_sk* 2>/dev/null | head -n1)

# Añadir la clave al agente ssh si está disponible
if command -v ssh-add >/dev/null 2>&1; then
    eval "$(ssh-agent -s)"
    ssh-add "$KEYFILE"
fi

read -p "¿Quieres extraer el config personalizado de ismola? (Si/No): " RESP
if [[ "$RESP" =~ ^([sS][iI]|[sS][íÍ])$ ]]; then
    TMPDIR=$(mktemp -d)
    GIT_SSH_COMMAND="ssh -i ~/.ssh/$KEYFILE" git clone --depth=1 --filter=blob:none git@github.com:Ismola/personal-ssh-config.git "$TMPDIR"
    if [ -f "$TMPDIR/config" ]; then
        cp "$TMPDIR/config" ~/.ssh/config
        chmod 600 ~/.ssh/config
        echo "Archivo de configuración SSH descargado y aplicado en ~/.ssh/config"
    else
        echo "ERROR: No se encontró el archivo 'config' en el repositorio clonado."
    fi
    rm -rf "$TMPDIR"
fi
git sparse-checkout set config
cp config ~/.ssh/config
chmod 600 ~/.ssh/config
cd ~
rm -rf "$TMPDIR"
rm ~/.ssh/config.tmp
echo "Archivo de configuración SSH descargado y aplicado en ~/.ssh/config"
