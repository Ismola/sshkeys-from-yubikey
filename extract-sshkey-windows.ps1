$sshDir = "$env:USERPROFILE\.ssh"

# Crear la carpeta .ssh si no existe
if (-not (Test-Path $sshDir)) {
    New-Item -ItemType Directory -Path $sshDir -Force | Out-Null
    Write-Host "Carpeta .ssh creada en: $sshDir"
}

Set-Location $sshDir
Write-Host "Inserta tu YubiKey y toca el dispositivo cuando se te pida."
ssh-keygen -K
Write-Host "Claves SSH extraídas desde la YubiKey."

# Detectar la clave privada recién extraída (la más reciente id_ed25519_sk*, excluyendo .pub)
$keyFile = Get-ChildItem -Filter "id_ed25519_sk*" | Where-Object { $_.Extension -ne ".pub" } | Sort-Object LastWriteTime -Descending | Select-Object -First 1

if (-not $keyFile) {
    Write-Host "ERROR: No se encontró ninguna clave SSH generada."
    exit 1
}

# Preguntar si se quiere extraer el config personalizado de ismola
$resp = Read-Host "¿Eres ismola? (Si/No)"
if ($resp -match '^(si|sí|SI|Si|sI|SÍ)$') {
    $TmpDir = New-TemporaryFile | % { Remove-Item $_; New-Item -ItemType Directory -Path $_ }
    $keyPath = Join-Path $env:USERPROFILE ".ssh\$($keyFile.Name)"
    # Usar la ruta completa de la clave privada como en el ejemplo funcional
    $env:GIT_SSH_COMMAND = "ssh -i `"$keyPath`""
    git clone "git@github.com:Ismola/personal-ssh-config.git" $TmpDir

    $configPath = Join-Path $TmpDir "config"
    $destConfig = "$env:USERPROFILE\.ssh\config"
    
    if (Test-Path $configPath) {
        if (Test-Path $destConfig) {
            # Remover atributo de solo lectura si existe
            $file = Get-Item $destConfig -ErrorAction SilentlyContinue
            if ($file) {
                $file.Attributes = $file.Attributes -band -bnot [System.IO.FileAttributes]::ReadOnly
            }
            # Intentar eliminar el archivo
            Remove-Item $destConfig -Force -ErrorAction SilentlyContinue
        }
        Copy-Item $configPath $destConfig -Force -ErrorAction SilentlyContinue
        if (Test-Path $destConfig) {
            # Establecer permisos de lectura
            try {
                icacls $destConfig /inheritance:r /grant:r "$($env:USERNAME):R" 2>$null | Out-Null
            } catch {
                # Si icacls falla, continuar de todas formas
            }
            Write-Host "Archivo de configuración SSH descargado y aplicado en .ssh\config"
        } else {
            Write-Host "ADVERTENCIA: No se pudo copiar el archivo 'config'."
        }
    } else {
        # Si no existe config en el repositorio clonado, crear uno vacío
        Write-Host "ADVERTENCIA: No se encontró el archivo 'config' en el repositorio clonado. Creando archivo vacío."
        if (Test-Path $destConfig) {
            $file = Get-Item $destConfig -ErrorAction SilentlyContinue
            if ($file) {
                $file.Attributes = $file.Attributes -band -bnot [System.IO.FileAttributes]::ReadOnly
            }
            Remove-Item $destConfig -Force -ErrorAction SilentlyContinue
        }
        New-Item -ItemType File -Path $destConfig -Force | Out-Null
        try {
            icacls $destConfig /inheritance:r /grant:r "$($env:USERNAME):R" 2>$null | Out-Null
        } catch {
            # Si icacls falla, continuar de todas formas
        }
        Write-Host "Archivo SSH config creado en: $destConfig"
    }

    if (Test-Path $TmpDir) { Remove-Item $TmpDir -Recurse -Force }
    if (Test-Path Env:\GIT_SSH_COMMAND) { Remove-Item Env:GIT_SSH_COMMAND }
}

Set-Location $env:USERPROFILE

if ($TmpDir -and (Test-Path $TmpDir)) { Remove-Item $TmpDir -Recurse -Force }
if (Test-Path Env:\GIT_SSH_COMMAND) { Remove-Item Env:\GIT_SSH_COMMAND }
