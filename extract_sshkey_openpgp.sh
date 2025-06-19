#!/bin/bash
# Extrae la clave pública SSH de una YubiKey usando OpenPGP

# Requiere: gpg, gpg-agent, ykman, openssh

# Detectar YubiKey
if ! gpg --card-status | grep -q "Yubikey"; then
  echo "No se detectó una YubiKey con OpenPGP."
  exit 1
fi

# Extraer clave pública SSH
gpg --export-ssh-key "$(gpg --card-status | grep 'sec>' | awk '{print $4}')" > yubikey-openpgp-sshkey.pub

echo "Clave pública SSH extraída en yubikey-openpgp-sshkey.pub"
