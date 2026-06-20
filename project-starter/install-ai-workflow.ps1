#Requires -Version 5.1
<#
.SYNOPSIS
  Install or refresh the GxP AI workflow files into a target project.

.DESCRIPTION
  Copies every path listed in workflow-manifest.json from this repository
  (glowing-engine) into -Destination, preserving directory structure.
  Use after cloning/upgrading glowing-engine to push workflow updates into apps.

.EXAMPLE
  .\project-starter\install-ai-workflow.ps1 -Destination "C:\Projects\my-app"

.EXAMPLE
  .\project-starter\install-ai-workflow.ps1 -Destination "C:\Projects\my-app" -Source "C:\src\glowing-engine"
#>
param(
    [Parameter(Mandatory = $true)]
    [string]$Destination,

    [string]$Source,

    [switch]$Force,

    [switch]$SkipOptional
)

$ErrorActionPreference = 'Stop'

$KitDir = $PSScriptRoot
$SourceRoot = if ($Source) {
    (Resolve-Path $Source).Path
} else {
    (Resolve-Path (Join-Path $KitDir '..')).Path
}

$DestPath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($Destination)
$ManifestPath = Join-Path $KitDir 'workflow-manifest.json'

if (-not (Test-Path -LiteralPath $ManifestPath)) {
    throw "Missing workflow manifest: $ManifestPath"
}

$manifest = Get-Content -LiteralPath $ManifestPath -Raw | ConvertFrom-Json

if (-not (Test-Path -LiteralPath $DestPath)) {
    New-Item -ItemType Directory -Path $DestPath -Force | Out-Null
}

function Copy-WorkflowPath {
    param(
        [string]$RelativePath,
        [string]$FromRoot,
        [string]$ToRoot
    )

    $src = Join-Path $FromRoot $RelativePath
    $dst = Join-Path $ToRoot $RelativePath

    if (-not (Test-Path -LiteralPath $src)) {
        Write-Warning "Skip missing source: $RelativePath"
        return
    }

    $dstParent = Split-Path -Parent $dst
    if ($dstParent -and -not (Test-Path -LiteralPath $dstParent)) {
        New-Item -ItemType Directory -Path $dstParent -Force | Out-Null
    }

    if (Test-Path -LiteralPath $src -PathType Container) {
        if ((Test-Path -LiteralPath $dst) -and -not $Force) {
            # Merge: robocopy into existing folder
            & robocopy $src $dst /E /NFL /NDL /NJH /NJS /NC /NS | Out-Null
            if ($LASTEXITCODE -ge 8) { throw "Robocopy failed for $RelativePath (exit $LASTEXITCODE)" }
        } else {
            if (Test-Path -LiteralPath $dst) { Remove-Item -LiteralPath $dst -Recurse -Force }
            Copy-Item -LiteralPath $src -Destination $dst -Recurse -Force
        }
    } else {
        if ((Test-Path -LiteralPath $dst) -and -not $Force) {
            Write-Host "  skip file (exists): $RelativePath"
            return
        }
        Copy-Item -LiteralPath $src -Destination $dst -Force
    }

    Write-Host "  copied: $RelativePath"
}

Write-Host "Installing GxP AI workflow"
Write-Host "  from: $SourceRoot"
Write-Host "  to:   $DestPath"
Write-Host ""

foreach ($entry in $manifest.paths) {
    if ($SkipOptional -and -not $entry.required) { continue }
    Copy-WorkflowPath -RelativePath $entry.path -FromRoot $SourceRoot -ToRoot $DestPath
}

# Project-specific templates (only when missing unless -Force)
$templateMap = @{
    'baseline-.md' = $manifest.templates.baseline
    'agent-workflow/HANDOFF.md' = $manifest.templates.handoff
    'agent-workflow/PLAN.md' = $manifest.templates.plan
}

foreach ($destRel in $templateMap.Keys) {
    $templateRel = $templateMap[$destRel] -replace '^project-starter/', ''
    $templateSrc = Join-Path $KitDir $templateRel
    $templateDst = Join-Path $DestPath $destRel

    if ((Test-Path -LiteralPath $templateDst) -and -not $Force) {
        Write-Host "  keep existing: $destRel"
        continue
    }

    $parent = Split-Path -Parent $templateDst
    if ($parent -and -not (Test-Path -LiteralPath $parent)) {
        New-Item -ItemType Directory -Path $parent -Force | Out-Null
    }

    Copy-Item -LiteralPath $templateSrc -Destination $templateDst -Force
    Write-Host "  seeded template: $destRel"
}

# Append .gitignore lines
$gitignoreAppend = Join-Path $KitDir ($manifest.gitignoreAppend -replace '^project-starter/', '')
$gitignoreDest = Join-Path $DestPath '.gitignore'
if (Test-Path -LiteralPath $gitignoreAppend) {
    $appendLines = Get-Content -LiteralPath $gitignoreAppend | Where-Object { $_ -and -not $_.StartsWith('#') -or $_.StartsWith('#') }
    $existing = if (Test-Path -LiteralPath $gitignoreDest) { Get-Content -LiteralPath $gitignoreDest -Raw } else { '' }

    $toAdd = @()
    foreach ($line in $appendLines) {
        if ($line.Trim() -eq '') { continue }
        if ($existing -notmatch [regex]::Escape($line.Trim())) {
            $toAdd += $line
        }
    }

    if ($toAdd.Count -gt 0) {
        $block = @(
            '',
            '# --- GxP AI workflow (project-starter) ---'
        ) + $toAdd
        Add-Content -LiteralPath $gitignoreDest -Value ($block -join "`n")
        Write-Host "  updated: .gitignore ($($toAdd.Count) lines added)"
    }
}

Write-Host ""
Write-Host "Done. Manual steps:"
Write-Host "  1. Merge scripts from project-starter/templates/package-scripts.json into package.json"
Write-Host "  2. Read project-starter/UPGRADE.md if refreshing an existing project"
Write-Host "  3. Run npm run db:map and npm run graphify:update in the target project when ready"
