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

# Crear config temporal para github usando la clave recién extraída
cat > ~/.ssh/config.tmp <<EOF
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/$KEYFILE
  IdentitiesOnly yes
EOF

# Clonar el repo usando el config temporal y la clave extraída
TMPDIR=$(mktemp -d)
GIT_SSH_COMMAND="ssh -F ~/.ssh/config.tmp" git clone --depth=1 --filter=blob:none --sparse git@github.com:Ismola/personal-ssh-config.git "$TMPDIR"
cd "$TMPDIR"
git sparse-checkout set config
cp config ~/.ssh/config
chmod 600 ~/.ssh/config
cd ~
rm -rf "$TMPDIR"
rm ~/.ssh/config.tmp
echo "Archivo de configuración SSH descargado y aplicado en ~/.ssh/config"
