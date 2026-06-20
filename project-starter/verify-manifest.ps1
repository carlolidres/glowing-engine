#Requires -Version 5.1
# Verify every path in workflow-manifest.json exists in the repository.
param(
    [string]$Source
)

$ErrorActionPreference = 'Stop'
$KitDir = $PSScriptRoot
$SourceRoot = if ($Source) { (Resolve-Path $Source).Path } else { (Resolve-Path (Join-Path $KitDir '..')).Path }
$ManifestPath = Join-Path $KitDir 'workflow-manifest.json'
$manifest = Get-Content -LiteralPath $ManifestPath -Raw | ConvertFrom-Json

$missing = @()
foreach ($entry in $manifest.paths) {
    $full = Join-Path $SourceRoot $entry.path
    if (-not (Test-Path -LiteralPath $full)) {
        $missing += $entry.path
    }
}

foreach ($prop in $manifest.templates.PSObject.Properties) {
    $rel = $prop.Value -replace '^project-starter/', ''
    $full = Join-Path $KitDir $rel
    if (-not (Test-Path -LiteralPath $full)) {
        $missing += $prop.Value
    }
}

$extra = @($manifest.gitignoreAppend, $manifest.packageScripts)
foreach ($rel in $extra) {
    $local = Join-Path $KitDir ($rel -replace '^project-starter/', '')
    if (-not (Test-Path -LiteralPath $local)) {
        $missing += $rel
    }
}

if ($missing.Count -gt 0) {
    Write-Error "Manifest references missing paths:`n  $($missing -join "`n  ")"
}

Write-Host "workflow-manifest.json OK ($($manifest.paths.Count) paths, source: $SourceRoot)"
