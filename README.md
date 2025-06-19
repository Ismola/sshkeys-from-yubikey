# sshkeys-from-yubikey
A cross-platform tool (Linux &amp; Windows) to extract and display public SSH keys stored on a YubiKey. Useful for quickly retrieving FIDO2 (e.g., sk-ssh-ed25519@openssh.com) or PIV-based keys for use in authorized_keys, CI pipelines, or SSH agents.

## Uso rápido

### Linux/macOS (FIDO2)

```bash
curl -O https://raw.githubusercontent.com/Ismola/sshkeys-from-yubikey/main/extract_sshkey_fido2.sh && \
chmod +x extract_sshkey_fido2.sh && \
./extract_sshkey_fido2.sh
```

### Windows (FIDO2)

```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Ismola/sshkeys-from-yubikey/main/extract_sshkey_fido2.ps1" -OutFile "extract_sshkey_fido2.ps1"
# Mueve el archivo a una carpeta local si lo descargaste en una ruta de red
powershell -ExecutionPolicy Bypass -File .\extract_sshkey_fido2.ps1
```

> **Nota:** Ejecuta el script desde una carpeta local de Windows, no desde una ruta de red o WSL, para evitar restricciones de PowerShell.
.\extract_sshkey_fido2.ps1
```

> **Nota:** Ejecuta el script desde una carpeta local de Windows, no desde una ruta de red o WSL, para evitar restricciones de PowerShell.
