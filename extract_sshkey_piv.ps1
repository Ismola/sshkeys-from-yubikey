# Extrae la clave pública SSH de una YubiKey usando PIV (PKCS#11) en Windows

# Requiere: Yubico PIV Tool, OpenSC, OpenSSH

# Detectar YubiKey
if (-not (Get-Command "yubico-piv-tool.exe" -ErrorAction SilentlyContinue)) {
    Write-Error "No se encontró yubico-piv-tool.exe en el PATH."
    exit 1
}

# Extraer clave pública
& "C:\Program Files\OpenSC Project\OpenSC\pkcs11-tool.exe" --module "C:\Program Files\OpenSC Project\OpenSC\opensc-pkcs11.dll" -r -y pubkey --slot 0 --id 01 > pubkey.pem

# Convertir a formato SSH
ssh-keygen.exe -i -m PKCS8 -f pubkey.pem > yubikey-piv-sshkey.pub

Write-Output "Clave pública SSH extraída en yubikey-piv-sshkey.pub"
