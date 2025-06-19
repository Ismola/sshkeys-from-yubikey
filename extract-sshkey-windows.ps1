Set-Location $env:USERPROFILE\.ssh
Write-Host "Inserta tu YubiKey y toca el dispositivo cuando se te pida."
ssh-keygen -K
Write-Host "Claves SSH extraídas desde la YubiKey."

# Detectar la clave privada recién extraída (la más reciente id_ed25519_sk*, excluyendo .pub)
$keyFile = Get-ChildItem -Filter "id_ed25519_sk*" | Where-Object { $_.Extension -ne ".pub" } | Sort-Object LastWriteTime -Descending | Select-Object -First 1

# Preguntar si se quiere extraer el config personalizado de ismola
$resp = Read-Host "¿Quieres extraer el config personalizado de ismola? (Si/No)"
if ($resp -match '^(si|sí|SI|Si|sI|SÍ)$') {
    $TmpDir = New-TemporaryFile | % { Remove-Item $_; New-Item -ItemType Directory -Path $_ }
    $keyPath = Join-Path $env:USERPROFILE ".ssh\$($keyFile.Name)"
    # Usar la ruta completa de la clave privada como en el ejemplo funcional
    $env:GIT_SSH_COMMAND = "ssh -i `"$keyPath`""
    git clone "git@github.com:Ismola/personal-ssh-config.git" $TmpDir

    $configPath = Join-Path $TmpDir "config"
    if (Test-Path $configPath) {
        Copy-Item $configPath "$env:USERPROFILE\.ssh\config" -Force
        icacls "$env:USERPROFILE\.ssh\config" /inheritance:r /grant:r "$($env:USERNAME):R"
        Write-Host "Archivo de configuración SSH descargado y aplicado en .ssh\config"
    } else {
        Write-Host "ERROR: No se encontró el archivo 'config' en el repositorio clonado."
    }

    if (Test-Path $TmpDir) { Remove-Item $TmpDir -Recurse -Force }
    if (Test-Path Env:\GIT_SSH_COMMAND) { Remove-Item Env:GIT_SSH_COMMAND }
}

Set-Location $env:USERPROFILE
if ($TmpDir -and (Test-Path $TmpDir)) { Remove-Item $TmpDir -Recurse -Force }
if ($configTmp -and (Test-Path $configTmp)) { Remove-Item $configTmp }
if (Test-Path Env:\GIT_SSH_COMMAND) { Remove-Item Env:GIT_SSH_COMMAND }
Set-Location $env:USERPROFILE
Remove-Item $TmpDir -Recurse -Force
Remove-Item $configTmp
Remove-Item Env:GIT_SSH_COMMAND
