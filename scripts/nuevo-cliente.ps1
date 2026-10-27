<#
.SYNOPSIS
  Clona la plantilla de un nicho en /clientes/<slug>/.

.EXAMPLE
  .\scripts\nuevo-cliente.ps1 -Nicho bienestar -Slug santuario-raiz
  .\scripts\nuevo-cliente.ps1 bienestar santuario-raiz -Abrir
#>
param(
  [Parameter(Mandatory = $true, Position = 0)]
  [ValidateSet("bienestar", "turismo", "salud", "tiendas")]
  [string]$Nicho,

  [Parameter(Mandatory = $true, Position = 1)]
  [ValidatePattern("^[a-z0-9]+(-[a-z0-9]+)*$")]
  [string]$Slug,

  # Sobrescribe la carpeta del cliente si ya existe
  [switch]$Force,

  # Abre el index.html resultante en el navegador predeterminado
  [switch]$Abrir
)

$ErrorActionPreference = "Stop"

$raiz      = Split-Path -Parent $PSScriptRoot
$plantilla = Join-Path $raiz "templates\$Nicho"
$destino   = Join-Path $raiz "clientes\$Slug"

if (-not (Test-Path (Join-Path $plantilla "index.html"))) {
  Write-Error "La plantilla '$Nicho' todavia no tiene index.html ($plantilla)."
}

if (Test-Path $destino) {
  if (-not $Force) {
    Write-Error "Ya existe 'clientes\$Slug'. Usa -Force para sobrescribirlo."
  }
  Remove-Item -Recurse -Force $destino
}

New-Item -ItemType Directory -Path $destino | Out-Null
Get-ChildItem -Path $plantilla -Force |
  Where-Object { $_.Name -ne ".gitkeep" } |
  Copy-Item -Destination $destino -Recurse -Force

$index = Join-Path $destino "index.html"
Write-Host ""
Write-Host "Cliente creado: clientes\$Slug  (plantilla: $Nicho)" -ForegroundColor Green
Write-Host "Siguiente paso: edita el objeto CLIENTE en $index"
Write-Host ""

if ($Abrir) { Invoke-Item $index }
