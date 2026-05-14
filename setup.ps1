# ============================================================
#  WattLogic — Setup & Fix Script
#  Ejecutar desde la carpeta: Escritorio\files\
#  PowerShell: Right-click > "Run with PowerShell"
#  O en terminal: .\setup.ps1
# ============================================================

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  WattLogic — Setup Fix Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$filesDir   = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectDir = Join-Path $filesDir "wattlogic"

# ── 1. Eliminar carpeta corrupta {src si existe ──────────────
$badFolder = Join-Path $projectDir "{src"
if (Test-Path $badFolder) {
    Write-Host "Eliminando carpeta corrupta {src..." -ForegroundColor Yellow
    Remove-Item -Recurse -Force $badFolder
    Write-Host "  OK" -ForegroundColor Green
} else {
    Write-Host "Carpeta {src no encontrada (ya esta limpio)" -ForegroundColor Gray
}

# ── 2. Crear estructura de carpetas correcta ─────────────────
Write-Host ""
Write-Host "Creando estructura de carpetas..." -ForegroundColor Yellow

$folders = @(
    "src\components",
    "src\layouts",
    "src\pages\wiki",
    "src\data",
    "src\styles",
    "public"
)

foreach ($folder in $folders) {
    $path = Join-Path $projectDir $folder
    if (-not (Test-Path $path)) {
        New-Item -ItemType Directory -Path $path -Force | Out-Null
        Write-Host "  Creado: $folder" -ForegroundColor Green
    } else {
        Write-Host "  Existe: $folder" -ForegroundColor Gray
    }
}

# ── 3. Mover archivos sueltos a sus rutas correctas ──────────
Write-Host ""
Write-Host "Moviendo archivos sueltos..." -ForegroundColor Yellow

$fileMoves = @(
    @{ from = "BaseLayout.astro"; to = "src\layouts\BaseLayout.astro" },
    @{ from = "Calculator.astro"; to = "src\components\Calculator.astro" },
    @{ from = "global.css";       to = "src\styles\global.css" },
    @{ from = "hsp-cities.json";  to = "src\data\hsp-cities.json" }
)

foreach ($move in $fileMoves) {
    $src  = Join-Path $filesDir $move.from
    $dest = Join-Path $projectDir $move.to
    if (Test-Path $src) {
        Copy-Item -Path $src -Destination $dest -Force
        Write-Host "  Movido: $($move.from) -> wattlogic\$($move.to)" -ForegroundColor Green
    } else {
        Write-Host "  No encontrado: $($move.from) (usa el del ZIP)" -ForegroundColor DarkYellow
    }
}

# ── 4. Verificar archivos clave ──────────────────────────────
Write-Host ""
Write-Host "Verificando archivos clave..." -ForegroundColor Yellow

$required = @(
    "astro.config.mjs",
    "package.json",
    "tailwind.config.mjs",
    "src\layouts\BaseLayout.astro",
    "src\components\Calculator.astro",
    "src\pages\index.astro",
    "src\styles\global.css",
    "src\data\hsp-cities.json"
)

$allGood = $true
foreach ($file in $required) {
    $path = Join-Path $projectDir $file
    if (Test-Path $path) {
        Write-Host "  OK: $file" -ForegroundColor Green
    } else {
        Write-Host "  FALTA: $file" -ForegroundColor Red
        $allGood = $false
    }
}

# ── 5. Instalar dependencias y arrancar ──────────────────────
Write-Host ""
if ($allGood) {
    Write-Host "Estructura correcta. Instalando dependencias..." -ForegroundColor Cyan
    Set-Location $projectDir
    npm install
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "  Listo! Arrancando servidor de dev..." -ForegroundColor Green
    Write-Host "  Abre: http://localhost:4321" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    npm run dev
} else {
    Write-Host "Faltan archivos. Extrae primero el ZIP completo." -ForegroundColor Red
    Write-Host "Luego vuelve a ejecutar este script." -ForegroundColor Red
}
