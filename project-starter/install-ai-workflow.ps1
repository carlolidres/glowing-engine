# Install AI agent workflow files into an existing or empty project directory.
# Usage: .\install-ai-workflow.ps1 -DestPath "C:\path\to\project" [-Force]

param(
    [Parameter(Mandatory = $true)]
    [Alias('Destination')]
    [string]$DestPath,
    [switch]$Force
)

$ErrorActionPreference = 'Stop'
$KitDir = $PSScriptRoot
$SourceRoot = Split-Path $KitDir -Parent

function Merge-WorkflowPackageJson {
    param([string]$TargetRoot)
    $pkgPath = Join-Path $TargetRoot 'package.json'
    $scriptsPath = Join-Path $KitDir 'templates\package-scripts.json'
    $stubPath = Join-Path $KitDir 'templates\package.json.stub'
    $requiredScripts = Get-Content $scriptsPath -Raw | ConvertFrom-Json

    $mergedScripts = @{}
    foreach ($prop in $requiredScripts.PSObject.Properties) {
        $mergedScripts[$prop.Name] = $prop.Value
    }

    if (Test-Path $pkgPath) {
        $pkg = Get-Content $pkgPath -Raw | ConvertFrom-Json
        if ($pkg.scripts) {
            foreach ($prop in $pkg.scripts.PSObject.Properties) {
                if (-not $mergedScripts.ContainsKey($prop.Name)) {
                    $mergedScripts[$prop.Name] = $prop.Value
                }
            }
        }
    } else {
        $pkg = Get-Content $stubPath -Raw | ConvertFrom-Json
    }

    $out = [ordered]@{
        name    = $pkg.name
        private = $pkg.private
        version = $pkg.version
        type    = $pkg.type
        scripts = $mergedScripts
    }
    if ($pkg.PSObject.Properties['dependencies']) {
        $out.dependencies = $pkg.dependencies
    }
    if ($pkg.PSObject.Properties['devDependencies']) {
        $out.devDependencies = $pkg.devDependencies
    }

    $json = $out | ConvertTo-Json -Depth 10
    $utf8NoBom = New-Object System.Text.UTF8Encoding $false
    [System.IO.File]::WriteAllText($pkgPath, $json, $utf8NoBom)
    Write-Host "  package.json - workflow npm scripts merged"
}

if (-not (Test-Path $DestPath)) {
    New-Item -ItemType Directory -Path $DestPath -Force | Out-Null
}
$DestPath = (Resolve-Path $DestPath).Path

$isFreshInstall = -not (Test-Path (Join-Path $DestPath 'AGENTS.md'))

Write-Host "Installing AI workflow from: $SourceRoot"
Write-Host "Destination: $DestPath"
if ($isFreshInstall) {
    Write-Host "Fresh install detected - will seed HANDOFF/PLAN/baseline templates and create package.json"
}

$manifest = Get-Content (Join-Path $KitDir 'workflow-manifest.json') -Raw | ConvertFrom-Json

foreach ($entry in $manifest.paths) {
    $src = Join-Path $SourceRoot $entry.path
    $dst = Join-Path $DestPath $entry.path

    if (-not (Test-Path $src)) {
        Write-Warning "Source missing (skipped): $($entry.path)"
        continue
    }

    $dstParent = Split-Path $dst -Parent
    if ($dstParent -and -not (Test-Path $dstParent)) {
        New-Item -ItemType Directory -Path $dstParent -Force | Out-Null
    }

    if (Test-Path $src -PathType Container) {
        if ((Test-Path $dst) -and -not $Force) {
            Write-Host "  keep existing folder: $($entry.path)"
            continue
        }
        if (Test-Path $dst) { Remove-Item $dst -Recurse -Force }
        Copy-Item $src $dst -Recurse -Force
    } else {
        if ((Test-Path $dst) -and -not $Force) {
            Write-Host "  keep existing file: $($entry.path)"
            continue
        }
        Copy-Item $src $dst -Force
    }
    Write-Host "  copied: $($entry.path)"
}

$templateMap = @{
    'baseline-.md'              = 'templates\baseline-.md'
    'agent-workflow\HANDOFF.md' = 'templates\HANDOFF.md'
    'agent-workflow\PLAN.md'    = 'templates\PLAN.md'
}
$seedOnFresh = $isFreshInstall -or $Force

foreach ($destRel in $templateMap.Keys) {
    $src = Join-Path $KitDir $templateMap[$destRel]
    $dst = Join-Path $DestPath $destRel
    if (-not (Test-Path $src)) {
        Write-Warning "Template missing: $($templateMap[$destRel])"
        continue
    }
    if ($seedOnFresh -or -not (Test-Path $dst)) {
        $dstParent = Split-Path $dst -Parent
        if (-not (Test-Path $dstParent)) {
            New-Item -ItemType Directory -Path $dstParent -Force | Out-Null
        }
        Copy-Item $src $dst -Force
        Write-Host "  seeded template: $destRel"
    } else {
        Write-Host "  keep existing: $destRel"
    }
}

Merge-WorkflowPackageJson -TargetRoot $DestPath

$gitignoreDest = Join-Path $DestPath '.gitignore'
$appendPath = Join-Path $KitDir 'templates\gitignore-append.txt'
if (Test-Path $appendPath) {
    $appendLines = Get-Content $appendPath | Where-Object { $_.Trim() -ne '' }
    $existing = if (Test-Path $gitignoreDest) { Get-Content $gitignoreDest -Raw } else { '' }
    $toAdd = @()
    foreach ($line in $appendLines) {
        if ($existing -notmatch [regex]::Escape($line.Trim())) {
            $toAdd += $line
        }
    }
    if ($toAdd.Count -gt 0) {
        if (-not (Test-Path $gitignoreDest)) {
            Set-Content -Path $gitignoreDest -Value '# --- GxP AI workflow (project-starter) ---' -Encoding utf8
        } elseif ($existing -notmatch 'GxP AI workflow') {
            Add-Content -Path $gitignoreDest -Value "`n# --- GxP AI workflow (project-starter) ---"
        }
        Add-Content -Path $gitignoreDest -Value ($toAdd -join "`n")
        Write-Host "  updated: .gitignore"
    }
}

Write-Host ""
Write-Host "Done. Next steps:"
Write-Host "  1. Edit baseline-.md for your project"
Write-Host "  2. npm install (if package.json was created or scripts were added)"
Write-Host "  3. npm run verify:workflow && npm run db:map"
Write-Host "  4. For full app + schema mock checks: use export-template.ps1 or copy src/ from template"
