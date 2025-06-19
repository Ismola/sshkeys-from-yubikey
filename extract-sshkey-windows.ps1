Set-Location $env:USERPROFILE\.ssh
Write-Host "Inserta tu YubiKey y toca el dispositivo cuando se te pida."
ssh-keygen -K
Write-Host "Claves SSH extraídas desde la YubiKey."

# Detectar la clave privada recién extraída (la más reciente id_ed25519_sk*)
$keyFile = Get-ChildItem -Filter "id_ed25519_sk*" | Sort-Object LastWriteTime -Descending | Select-Object -First 1

# Crear config temporal para github
$configTmp = "$env:USERPROFILE\.ssh\config.tmp"
@"
Host github.com
  HostName github.com
  User git
  IdentityFile $env:USERPROFILE\.ssh\$($keyFile.Name)
  IdentitiesOnly yes
"@ | Set-Content $configTmp

# Clonar el repo usando el config temporal
$TmpDir = New-TemporaryFile | % { Remove-Item $_; New-Item -ItemType Directory -Path $_ }
$env:GIT_SSH_COMMAND = "ssh -F $configTmp"
git clone --depth=1 --filter=blob:none --sparse "git@github.com:Ismola/personal-ssh-config.git" $TmpDir
Set-Location $TmpDir
git sparse-checkout set config
Copy-Item "$TmpDir\config" "$env:USERPROFILE\.ssh\config" -Force
icacls "$env:USERPROFILE\.ssh\config" /inheritance:r /grant:r "$($env:USERNAME):R"
Set-Location $env:USERPROFILE
Remove-Item $TmpDir -Recurse -Force
Remove-Item $configTmp
Remove-Item Env:GIT_SSH_COMMAND
Write-Host "Archivo de configuración SSH descargado y aplicado en .ssh\config"
