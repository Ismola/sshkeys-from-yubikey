#!/bin/bash
set -e

SSH_DIR="$HOME/.ssh"

# Crear la carpeta .ssh si no existe
if [ ! -d "$SSH_DIR" ]; then
    mkdir -p "$SSH_DIR"
    chmod 700 "$SSH_DIR"
    echo "Carpeta .ssh creada en: $SSH_DIR"
fi

cd "$SSH_DIR"
echo "Inserta tu YubiKey y toca el dispositivo cuando se te pida."
ssh-keygen -K
echo "Claves SSH extraídas desde la YubiKey."

# Detectar la clave privada recién extraída (la más reciente id_ed25519_sk*, excluyendo .pub)
KEYFILE=$(ls -t id_ed25519_sk* 2>/dev/null | grep -v '\.pub$' | head -n1)

if [ -z "$KEYFILE" ]; then
    echo "ERROR: No se encontró ninguna clave SSH generada."
    exit 1
fi

# Añadir la clave al agente ssh si está disponible
if command -v ssh-add >/dev/null 2>&1; then
    eval "$(ssh-agent -s)"
    ssh-add "$KEYFILE"
fi

read -p "¿Eres ismola? (Si/No): " RESP
if [[ "$RESP" =~ ^([sS][iI]|[sS][íÍ])$ ]]; then
    TMPDIR=$(mktemp -d)
    GIT_SSH_COMMAND="ssh -i $SSH_DIR/$KEYFILE" git clone git@github.com:Ismola/personal-ssh-config.git "$TMPDIR"
    
    if [ -f "$TMPDIR/config" ]; then
        # Remover archivo existente si lo hay
        [ -f "$SSH_DIR/config" ] && rm -f "$SSH_DIR/config"
        cp "$TMPDIR/config" "$SSH_DIR/config"
        chmod 600 "$SSH_DIR/config"
        echo "Archivo de configuración SSH descargado y aplicado en $SSH_DIR/config"
    else
        # Si no existe config en el repositorio clonado, crear uno vacío
        echo "ADVERTENCIA: No se encontró el archivo 'config' en el repositorio clonado. Creando archivo vacío."
        [ -f "$SSH_DIR/config" ] && rm -f "$SSH_DIR/config"
        touch "$SSH_DIR/config"
        chmod 600 "$SSH_DIR/config"
        echo "Archivo SSH config creado en: $SSH_DIR/config"
    fi
    rm -rf "$TMPDIR"
fi

cd ~
