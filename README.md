# 🔑 sshkeys-from-yubikey

Scripts para extraer claves SSH almacenadas en tu YubiKey (FIDO2) en distintos sistemas operativos.

## Uso rápido

### Linux

```bash
curl -sL https://raw.githubusercontent.com/Ismola/sshkeys-from-yubikey/main/extract-sshkey-linux.sh | bash
```

### macOS

```bash
curl -sL https://raw.githubusercontent.com/Ismola/sshkeys-from-yubikey/main/extract-sshkey-macos.sh | bash
```

### Windows (PowerShell)

Abre PowerShell como administrador y ejecuta:

```powershell
irm https://raw.githubusercontent.com/Ismola/sshkeys-from-yubikey/main/extract-sshkey-windows.ps1 | iex
```

## ¿Qué hace el script?

- Cambia al directorio `~/.ssh` (o `%USERPROFILE%\.ssh` en Windows).
- Ejecuta `ssh-keygen -K` para regenerar los archivos de clave pública y privada desde tu YubiKey.
- Te pedirá el PIN y que toques la YubiKey.

## Requisitos

- OpenSSH 8.3 o superior.
- YubiKey configurada con clave FIDO2 residente.
- Tener configurado el PIN en la YubiKey.

## Referencias

- [Documentación oficial de Yubico](https://support.yubico.com/hc/en-us/articles/360016649039-Using-Your-YubiKey-with-SSH)
- [OpenSSH Manual](https://man.openbsd.org/ssh-keygen)
