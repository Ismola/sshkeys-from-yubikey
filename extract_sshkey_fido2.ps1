# Extrae la clave pública SSH de una YubiKey usando FIDO2 en Windows

# Requiere: OpenSSH >= 8.2p1

# Generar nueva clave SSH FIDO2 (requiere tocar la YubiKey)
ssh-keygen.exe -t ed25519-sk -f yubikey-fido2-sshkey -N ''

Write-Output "Clave pública SSH extraída en yubikey-fido2-sshkey.pub"
