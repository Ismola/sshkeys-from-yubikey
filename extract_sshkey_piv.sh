#!/bin/bash
# Extrae la clave pública SSH de una YubiKey usando PIV (PKCS#11)

# Requiere: yubico-piv-tool, opensc, openssh

# Detectar YubiKey
if ! yubico-piv-tool -a status >/dev/null 2>&1; then
  echo "No se detectó una YubiKey con PIV."
  exit 1
fi

# Extraer clave pública SSH desde el slot 9a (autenticación)
pkcs11-tool --module /usr/lib/x86_64-linux-gnu/opensc-pkcs11.so -r -y pubkey --slot 0 --id 01 > pubkey.pem

# Convertir a formato SSH
ssh-keygen -i -m PKCS8 -f pubkey.pem > yubikey-piv-sshkey.pub

echo "Clave pública SSH extraída en yubikey-piv-sshkey.pub"
