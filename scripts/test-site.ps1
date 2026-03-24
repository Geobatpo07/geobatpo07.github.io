param(
    [string]$BaseUrl = "http://localhost:4000",
    [switch]$SkipBuild,
    [switch]$SkipRestart,
    [int]$TimeoutSec = 30
)

$ErrorActionPreference = "Stop"

function Write-Info([string]$Message) {
    Write-Host "[INFO] $Message" -ForegroundColor Cyan
}

function Write-Ok([string]$Message) {
    Write-Host "[OK]   $Message" -ForegroundColor Green
}

function Write-Fail([string]$Message) {
    Write-Host "[FAIL] $Message" -ForegroundColor Red
}

function Invoke-PageCheck {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Url,
        [int]$Timeout = 30
    )

    try {
        $response = Invoke-WebRequest -Uri $Url -UseBasicParsing -TimeoutSec $Timeout
        [PSCustomObject]@{
            Url     = $Url
            Ok      = $true
            Status  = [int]$response.StatusCode
            Bytes   = [int64]$response.RawContentLength
            Message = ""
        }
    }
    catch {
        [PSCustomObject]@{
            Url     = $Url
            Ok      = $false
            Status  = $null
            Bytes   = $null
            Message = $_.Exception.Message
        }
    }
}

Write-Info "Running app smoke tests"

Write-Info "Checking docker compose service status"
docker compose ps

if (-not $SkipRestart) {
    Write-Info "Restarting docker service"
    docker compose restart | Out-Null
}

$ready = $false
for ($i = 0; $i -lt 20; $i++) {
    try {
        $null = Invoke-WebRequest -Uri "$BaseUrl/" -UseBasicParsing -TimeoutSec 10
        $ready = $true
        break
    }
    catch {
        Start-Sleep -Seconds 2
    }
}

if (-not $ready) {
    Write-Fail "Site did not become ready at $BaseUrl"
    exit 1
}

Write-Ok "Site is reachable at $BaseUrl"

if (-not $SkipBuild) {
    Write-Info "Running Jekyll build in container"
    docker compose exec -T jekyll-site jekyll build --config _config.yml,_config_docker.yml
    Write-Ok "Jekyll build completed"
}

$urls = @(
    "$BaseUrl/",
    "$BaseUrl/blog/",
    "$BaseUrl/year-archive/",
    "$BaseUrl/portfolio/",
    "$BaseUrl/supervisors/",
    "$BaseUrl/posts/2026/03/compartmental-modeling-demographic-analysis/",
    "$BaseUrl/assets/images/posts/modelisation-compartimentale-guadeloupe.png"
)

Write-Info "Running endpoint checks"
$results = foreach ($url in $urls) {
    Invoke-PageCheck -Url $url -Timeout $TimeoutSec
}

$failed = $results | Where-Object { -not $_.Ok }

foreach ($r in $results) {
    if ($r.Ok) {
        Write-Ok ("{0} -> {1} ({2} bytes)" -f $r.Status, $r.Url, $r.Bytes)
    }
    else {
        Write-Fail ("{0} -> {1}" -f $r.Url, $r.Message)
    }
}

Write-Info "Checking sidebar and footer markers on key pages"
$layoutChecks = @(
    "$BaseUrl/blog/",
    "$BaseUrl/portfolio/",
    "$BaseUrl/supervisors/"
)

foreach ($u in $layoutChecks) {
    try {
        $html = (Invoke-WebRequest -Uri $u -UseBasicParsing -TimeoutSec $TimeoutSec).Content
        $hasSidebar = $html -match 'class="sidebar sticky"'
        $hasFooter = $html -match 'class="page__footer"'
        if ($hasSidebar -and $hasFooter) {
            Write-Ok ("Layout markers found -> {0} (sidebar={1}, footer={2})" -f $u, $hasSidebar, $hasFooter)
        }
        else {
            Write-Fail ("Layout markers missing -> {0} (sidebar={1}, footer={2})" -f $u, $hasSidebar, $hasFooter)
            $failed += [PSCustomObject]@{ Url = $u; Ok = $false }
        }
    }
    catch {
        Write-Fail ("Layout check failed -> {0}: {1}" -f $u, $_.Exception.Message)
        $failed += [PSCustomObject]@{ Url = $u; Ok = $false }
    }
}

if ($failed.Count -gt 0) {
    Write-Fail ("Smoke tests completed with {0} failure(s)." -f $failed.Count)
    exit 1
}

Write-Ok "All smoke tests passed."
exit 0
