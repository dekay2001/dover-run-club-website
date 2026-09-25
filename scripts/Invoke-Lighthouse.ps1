<#
.SYNOPSIS
    Runs a Lighthouse audit and prints a triage summary, optionally compared to a previous run.

.DESCRIPTION
    Uses `npx lighthouse` with a local Chrome or Edge install. Writes JSON + HTML reports to
    -OutputDir (outside the repo by default) and prints category scores, core metrics,
    failing audits with top offending elements, and deltas vs -CompareTo.

.EXAMPLE
    .\scripts\Invoke-Lighthouse.ps1

.EXAMPLE
    .\scripts\Invoke-Lighthouse.ps1 -Url http://localhost:4000/ -FormFactor desktop

.EXAMPLE
    .\scripts\Invoke-Lighthouse.ps1 -CompareTo "$env:TEMP\drc-lighthouse\lighthouse-mobile-20260925-120000.report.json"
#>
[CmdletBinding()]
param(
    [string]$Url = 'https://www.doverrunclub.com/',

    [ValidateSet('mobile', 'desktop')]
    [string]$FormFactor = 'mobile',

    [string]$OutputDir = (Join-Path $env:TEMP 'drc-lighthouse'),

    [ValidateScript({ Test-Path $_ -PathType Leaf })]
    [string]$CompareTo,

    [ValidateRange(1, 50)]
    [int]$MaxItems = 5,

    # Pinned so scoring stays comparable across runs; bump deliberately and re-baseline.
    [ValidatePattern('^\d+\.\d+\.\d+$')]
    [string]$LighthouseVersion = '13.5.0'
)

$ErrorActionPreference = 'Stop'

$categoryIds = 'performance', 'accessibility', 'best-practices', 'seo'
$metricIds = 'first-contentful-paint', 'largest-contentful-paint', 'total-blocking-time', 'cumulative-layout-shift', 'speed-index'

function Get-CategoryScores($Report) {
    $scores = [ordered]@{}
    foreach ($id in $categoryIds) { $scores[$id] = [math]::Round($Report.categories.$id.score * 100) }
    $scores
}

function Get-FailingAuditIds($Report) {
    $Report.audits.PSObject.Properties.Value |
        Where-Object { $null -ne $_.score -and $_.score -lt 1 -and $_.id -notin $metricIds } |
        ForEach-Object id
}

function Format-AuditItem($Item) {
    $parts = @()
    if ($Item.node.selector) { $parts += $Item.node.selector }
    if ($Item.url) { $parts += $Item.url }
    if ($Item.node.explanation) {
        $reason = ($Item.node.explanation -split "`n" | Where-Object { $_ -match '\S' } | Select-Object -Skip 1 -First 1)
        if ($reason) { $parts += $reason.Trim() }
    }
    if ($Item.wastedBytes) { $parts += '{0:N0} KiB wasted' -f ($Item.wastedBytes / 1KB) }
    elseif ($Item.totalBytes) { $parts += '{0:N0} KiB' -f ($Item.totalBytes / 1KB) }
    if ($Item.wastedMs) { $parts += '{0:N0} ms' -f $Item.wastedMs }
    $parts -join ' :: '
}

if (-not (Get-Command npx -ErrorAction SilentlyContinue)) {
    throw 'npx not found. Install Node.js (LTS) first.'
}

$baseline = if ($CompareTo) { Get-Content $CompareTo -Raw | ConvertFrom-Json }
if ($baseline) {
    if ($baseline.configSettings.formFactor -ne $FormFactor) {
        throw "-CompareTo report is '$($baseline.configSettings.formFactor)' but this run is '$FormFactor'. Compare like with like."
    }
    if ($baseline.requestedUrl -ne $Url) {
        Write-Warning "-CompareTo report audited $($baseline.requestedUrl), not $Url."
    }
    if ($baseline.lighthouseVersion -ne $LighthouseVersion) {
        Write-Warning "-CompareTo report used Lighthouse $($baseline.lighthouseVersion); this run uses $LighthouseVersion. Deltas may reflect scoring changes."
    }
}

$originalChromePath = $env:CHROME_PATH
if (-not $env:CHROME_PATH) {
    $browser = @(
        "$env:ProgramFiles\Google\Chrome\Application\chrome.exe",
        "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe",
        "$env:LOCALAPPDATA\Google\Chrome\Application\chrome.exe",
        "${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe",
        "$env:ProgramFiles\Microsoft\Edge\Application\msedge.exe"
    ) | Where-Object { Test-Path $_ } | Select-Object -First 1
    if (-not $browser) { throw 'No Chrome or Edge install found. Set $env:CHROME_PATH to a Chromium browser.' }
    $env:CHROME_PATH = $browser
}

try {
    New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
    $basePath = Join-Path $OutputDir ("lighthouse-{0}-{1}" -f $FormFactor, (Get-Date -Format 'yyyyMMdd-HHmmss'))
    $jsonPath = "$basePath.report.json"
    $htmlPath = "$basePath.report.html"

    $lighthouseArgs = @('--yes', "lighthouse@$LighthouseVersion", $Url, '--output=json', '--output=html', "--output-path=$basePath", '--chrome-flags=--headless=new', '--quiet')
    if ($FormFactor -eq 'desktop') { $lighthouseArgs += '--preset=desktop' }

    Write-Host "Auditing $Url ($FormFactor) with Lighthouse $LighthouseVersion and $env:CHROME_PATH ..." -ForegroundColor Cyan
    & npx @lighthouseArgs

    # On Windows, chrome-launcher can exit non-zero on temp-dir cleanup even when the report was written.
    if (-not (Test-Path $jsonPath)) { throw "Lighthouse did not produce a report (exit code $LASTEXITCODE)." }
}
finally {
    $env:CHROME_PATH = $originalChromePath
}

$report = Get-Content $jsonPath -Raw | ConvertFrom-Json

Write-Host "`n== Category scores" -ForegroundColor Yellow
$scores = Get-CategoryScores $report
$baselineScores = if ($baseline) { Get-CategoryScores $baseline }
foreach ($id in $categoryIds) {
    $line = '{0,-15} {1,3}' -f $id, $scores[$id]
    if ($baselineScores) { $line += '  (was {0}, {1:+0;-0;0})' -f $baselineScores[$id], ($scores[$id] - $baselineScores[$id]) }
    Write-Host $line
}

Write-Host "`n== Core metrics" -ForegroundColor Yellow
foreach ($id in $metricIds) {
    $audit = $report.audits.$id
    $line = '{0,-26} {1,-10} score {2}' -f $id, $audit.displayValue, $audit.score
    if ($baseline) { $line += '  (was {0})' -f $baseline.audits.$id.displayValue }
    Write-Host $line
}

Write-Host "`n== Failing audits" -ForegroundColor Yellow
foreach ($id in Get-FailingAuditIds $report) {
    $audit = $report.audits.$id
    Write-Host ('[{0}] {1} ({2}) {3}' -f $audit.score, $audit.title, $id, $audit.displayValue)
    $audit.details.items |
        ForEach-Object { Format-AuditItem $_ } |
        Where-Object { $_ } |
        Select-Object -First $MaxItems |
        ForEach-Object { Write-Host "    - $_" }
}

if ($baseline) {
    $now = @(Get-FailingAuditIds $report)
    $before = @(Get-FailingAuditIds $baseline)
    Write-Host "`n== Change vs baseline" -ForegroundColor Yellow
    Write-Host ('Fixed:     {0}' -f ((@($before | Where-Object { $_ -notin $now }) -join ', '), 'none' | Where-Object { $_ } | Select-Object -First 1))
    Write-Host ('New fails: {0}' -f ((@($now | Where-Object { $_ -notin $before }) -join ', '), 'none' | Where-Object { $_ } | Select-Object -First 1))
}

Write-Host "`nJSON: $jsonPath"
Write-Host "HTML: $htmlPath"
