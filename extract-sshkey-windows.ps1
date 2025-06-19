Set-Location $env:USERPROFILE\.ssh
Write-Host "Inserta tu YubiKey y toca el dispositivo cuando se te pida."
ssh-keygen -K
Write-Host "Claves SSH extraídas desde la YubiKey."
# Descargar el fichero config personalizado usando git+ssh
$TmpDir = New-TemporaryFile | % { Remove-Item $_; New-Item -ItemType Directory -Path $_ }
git clone --depth=1 --filter=blob:none --sparse "git@github.com:Ismola/personal-ssh-config.git" $TmpDir
Set-Location $TmpDir
git sparse-checkout set config
Copy-Item "$TmpDir\config" "$env:USERPROFILE\.ssh\config" -Force
icacls "$env:USERPROFILE\.ssh\config" /inheritance:r /grant:r "$($env:USERNAME):R"
Set-Location $env:USERPROFILE
Remove-Item $TmpDir -Recurse -Force
Write-Host "Archivo de configuración SSH descargado y aplicado en .ssh\config"
