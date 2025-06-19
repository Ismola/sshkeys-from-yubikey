Set-Location $env:USERPROFILE\.ssh
Write-Host "Inserta tu YubiKey y toca el dispositivo cuando se te pida."
ssh-keygen -K
Write-Host "Claves SSH extraídas desde la YubiKey."
