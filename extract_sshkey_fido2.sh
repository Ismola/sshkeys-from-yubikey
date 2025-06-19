#!/bin/bash
# Extrae la clave pública SSH de una YubiKey usando FIDO2

# Requiere: openssh >= 8.2p1, ykman

# Detectar YubiKey
if ! ykman info | grep -q "FIDO2"; then
  echo "No se detectó una YubiKey con FIDO2."
  exit 1
fi

# Generar nueva clave SSH FIDO2 (requiere tocar la YubiKey)
ssh-keygen -t ed25519-sk -f yubikey-fido2-sshkey -N ""

echo "Clave pública SSH extraída en yubikey-fido2-sshkey.pub"
