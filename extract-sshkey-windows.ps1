Set-Location $env:USERPROFILE\.ssh
Write-Host "Inserta tu YubiKey y toca el dispositivo cuando se te pida."
ssh-keygen -K
Write-Host "Claves SSH extraídas desde la YubiKey."
# Descargar el fichero config personalizado
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Ismola/personal-ssh-config/main/config" -OutFile "$env:USERPROFILE\.ssh\config"
icacls "$env:USERPROFILE\.ssh\config" /inheritance:r /grant:r "$($env:USERNAME):R"
Write-Host "Archivo de configuración SSH descargado y aplicado en .ssh\config"
