#Requires -Version 5.1
<#
.SYNOPSIS
  Export a clean GxP Toolkit copy to a new project folder.

.EXAMPLE
  .\project-starter\export-template.ps1 -Destination "C:\Projects\my-new-app"
#>
param(
    [Parameter(Mandatory = $true)]
    [string]$Destination,

    [switch]$Force
)

$ErrorActionPreference = 'Stop'

function Read-ExportIgnore {
    param([string]$Path)
    $dirs = [System.Collections.Generic.List[string]]::new()
    $files = [System.Collections.Generic.List[string]]::new()

    foreach ($line in Get-Content -LiteralPath $Path -ErrorAction Stop) {
        $t = $line.Trim()
        if (-not $t -or $t.StartsWith('#')) { continue }
        if ($t.EndsWith('/')) {
            $dirs.Add($t.TrimEnd('/'))
        } else {
            $files.Add($t)
        }
    }

    return @{ Dirs = $dirs; Files = $files }
}

$KitRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$DestPath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($Destination)
$IgnorePath = Join-Path $PSScriptRoot '.exportignore'
$ignore = Read-ExportIgnore -Path $IgnorePath

if (Test-Path -LiteralPath $DestPath) {
    $existing = Get-ChildItem -LiteralPath $DestPath -Force -ErrorAction SilentlyContinue
    if ($existing -and -not $Force) {
        throw "Destination is not empty: $DestPath. Use -Force to export anyway."
    }
} else {
    New-Item -ItemType Directory -Path $DestPath -Force | Out-Null
}

if (-not (Get-Command robocopy -ErrorAction SilentlyContinue)) {
    throw 'robocopy is required (included with Windows).'
}

$robocopyArgs = @(
    $KitRoot,
    $DestPath,
    '/E',
    '/NFL', '/NDL', '/NJH', '/NJS', '/NC', '/NS'
)

foreach ($d in $ignore.Dirs) {
    $robocopyArgs += '/XD'
    $robocopyArgs += $d
}

foreach ($f in $ignore.Files) {
    $robocopyArgs += '/XF'
    $robocopyArgs += $f
}

& robocopy @robocopyArgs | Out-Null
$code = $LASTEXITCODE

# Robocopy: 0-7 = success with various copy stats
if ($code -ge 8) {
    throw "Robocopy failed with exit code $code"
}

Write-Host ""
Write-Host "Exported GxP Toolkit template to:"
Write-Host "  $DestPath"
Write-Host ""
Write-Host "Next steps:"
Write-Host "  cd `"$DestPath`""
Write-Host "  npm install"
Write-Host "  copy .env.example .env.local"
Write-Host "  npm run dev"
Write-Host ""
Write-Host "See project-starter/CHECKLIST.md and FIRST_PROMPT.md"
