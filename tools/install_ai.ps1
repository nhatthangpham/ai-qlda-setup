# Install the AI tools for the current Windows user: Claude Code (native), Antigravity CLI (Gemini), Javis OS.
#   Check only:  powershell -ExecutionPolicy Bypass -File tools\install_ai.ps1 -Check
#   Install:     powershell -ExecutionPolicy Bypass -File tools\install_ai.ps1
# Run in a NORMAL PowerShell (not "Run as administrator"): these tools install into the user's profile.
# Run tools\install_base.ps1 first (Git, Python 3.12, Node, uv, Chrome, Claude Desktop ...).
# Sign-ins are NOT done here: see KET-NOI.md. No token or password is ever written by this script.
# ASCII only on purpose (Windows PowerShell 5.1 reads BOM-less files as ANSI).
#   Javis only, no QLDA team (coworker machine, see CAI-JAVIS.md): add -NoTeam
param([switch]$Check, [switch]$NoTeam)
$ErrorActionPreference = 'Continue'

$claudeExe = Join-Path $env:USERPROFILE '.local\bin\claude.exe'
$agyExe    = Join-Path $env:LOCALAPPDATA 'agy\bin\agy.exe'
$javisDir  = Join-Path $env:USERPROFILE 'javis'
$javisRepo = 'https://github.com/blogminhquy/javis-os.git'

$rows = New-Object System.Collections.ArrayList
function Add-Row($item, $status, $note) { [void]$rows.Add([pscustomobject]@{ Item = $item; Status = $status; Note = $note }) }
function Refresh-Path { $env:Path = [Environment]::GetEnvironmentVariable('Path', 'Machine') + ';' + [Environment]::GetEnvironmentVariable('Path', 'User') }
function Add-UserPath($dir) {
    $p = [Environment]::GetEnvironmentVariable('Path', 'User')
    if (-not (($p -split ';') -contains $dir)) { [Environment]::SetEnvironmentVariable('Path', ($p.TrimEnd(';') + ';' + $dir), 'User') }
    Refresh-Path
}
# Download an official installer script to a file first (so it can be read), then run it.
function Invoke-Installer($url, $name) {
    $f = Join-Path $env:TEMP "install_$name.ps1"
    Invoke-WebRequest -UseBasicParsing -Uri $url -OutFile $f
    "Running $url (saved at $f)"
    & powershell -NoProfile -ExecutionPolicy Bypass -File $f | Out-Host
}

$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if ($isAdmin -and -not $Check) { 'Warning: running as administrator. If the admin account is not the normal user, close this and use a normal PowerShell.' }
Refresh-Path
foreach ($t in 'git', 'py') {
    if (-not (Get-Command $t -ErrorAction SilentlyContinue)) { "Missing '$t'. Run tools\install_base.ps1 (as administrator) first."; exit 2 }
}

# --- 1. Claude Code, native build (Javis refuses the npm build 'claude.CMD')
if (-not (Test-Path $claudeExe) -and -not $Check) { Invoke-Installer 'https://claude.ai/install.ps1' 'claude' }
if (Test-Path $claudeExe) { Add-UserPath (Split-Path $claudeExe); Add-Row 'Claude Code (native)' 'OK' $claudeExe }
else { Add-Row 'Claude Code (native)' 'MISSING' 'https://claude.ai/install.ps1' }
$npmClaude = Get-Command claude.cmd -ErrorAction SilentlyContinue
if ($npmClaude) { Add-Row 'Claude Code npm build' 'WARN' "remove it: npm uninstall -g @anthropic-ai/claude-code ($($npmClaude.Source))" }

# --- 2. Antigravity CLI (Gemini brain for Javis, uses the Google account's plan)
if (-not (Test-Path $agyExe) -and -not $Check) { Invoke-Installer 'https://antigravity.google/cli/install.ps1' 'agy' }
Add-Row 'Antigravity CLI (Gemini)' $(if (Test-Path $agyExe) { 'OK' } else { 'MISSING' }) $agyExe

# --- 3. Javis OS (do NOT run its setup.bat: it installs extra software and enables autostart)
if (-not (Test-Path (Join-Path $javisDir '.git')) -and -not $Check) {
    "Cloning Javis into $javisDir ..."
    git clone $javisRepo $javisDir | Out-Host
}
$venvPy = Join-Path $javisDir '.venv\Scripts\python.exe'
if ((Test-Path $javisDir) -and -not (Test-Path $venvPy) -and -not $Check) {
    'Creating Javis Python environment (a few minutes) ...'
    Push-Location $javisDir
    py -3.12 -m venv .venv
    & $venvPy -m pip install --upgrade pip | Out-Null
    & $venvPy -m pip install -r requirements.txt | Out-Host
    Pop-Location
}
Add-Row 'Javis code' $(if (Test-Path (Join-Path $javisDir 'requirements.txt')) { 'OK' } else { 'MISSING' }) $javisDir
Add-Row 'Javis Python env' $(if (Test-Path $venvPy) { 'OK' } else { 'MISSING' }) $venvPy

# Desktop + Start Menu shortcut "Javis OS"
$openVbs = Join-Path $javisDir 'open-javis.vbs'
if ((Test-Path $openVbs) -and -not $Check) {
    $ws = New-Object -ComObject WScript.Shell
    $ico = Join-Path $javisDir 'packaging\assets\javis.ico'
    foreach ($dir in [Environment]::GetFolderPath('Desktop'), (Join-Path $env:APPDATA 'Microsoft\Windows\Start Menu\Programs')) {
        $lnk = $ws.CreateShortcut((Join-Path $dir 'Javis OS.lnk'))
        $lnk.TargetPath = "$env:WINDIR\System32\wscript.exe"
        $lnk.Arguments = "//nologo `"$openVbs`""
        $lnk.WorkingDirectory = $javisDir
        if (Test-Path $ico) { $lnk.IconLocation = $ico }
        $lnk.Save()
    }
}
$hasLnk = Test-Path (Join-Path ([Environment]::GetFolderPath('Desktop')) 'Javis OS.lnk')
Add-Row 'Javis shortcut on Desktop' $(if ($hasLnk) { 'OK' } else { 'MISSING' }) 'Javis OS.lnk'

# Start the Javis server in the background (never wait on it) and check health
function Test-Javis { try { (Invoke-WebRequest -UseBasicParsing -TimeoutSec 3 'http://127.0.0.1:7777/health').StatusCode -eq 200 } catch { $false } }
$up = Test-Javis
if (-not $up -and -not $Check -and (Test-Path (Join-Path $javisDir 'start-javis.vbs'))) {
    Start-Process wscript.exe -ArgumentList "//nologo `"$(Join-Path $javisDir 'start-javis.vbs')`"" -WorkingDirectory $javisDir
    for ($i = 0; $i -lt 30 -and -not $up; $i++) { Start-Sleep -Seconds 2; $up = Test-Javis }
}
Add-Row 'Javis server (port 7777)' $(if ($up) { 'OK' } else { 'MISSING' }) 'http://127.0.0.1:7777/health'

# --- 4. QLDA team for Javis: agents, workflows, memory template (never overwrites existing files)
$kit   = Join-Path (Split-Path $PSScriptRoot) 'javis-brain'
$brain = Join-Path $javisDir 'brains\Brain Default'
if ($NoTeam) {
    Add-Row 'QLDA team in Javis' 'SKIPPED' '-NoTeam'
} elseif (-not (Test-Path $brain)) {
    Add-Row 'QLDA team in Javis' 'MISSING' 'open Javis once (creates "Brain Default"), then run this script again'
} else {
    $copied = 0; $total = 0
    foreach ($sub in 'agents', 'workflows', 'memory\facts') {
        $src = Join-Path $kit $sub
        if (-not (Test-Path $src)) { continue }
        $dst = Join-Path $brain $sub
        foreach ($f in Get-ChildItem $src -File -Filter *.md) {
            $total++
            $target = Join-Path $dst $f.Name
            if (-not (Test-Path $target) -and -not $Check) {
                New-Item -ItemType Directory -Force $dst | Out-Null
                Copy-Item $f.FullName $target
            }
            if (Test-Path $target) { $copied++ }
        }
    }
    # one index line in MEMORY.md so Javis loads the owner profile every time
    $memIdx = Join-Path $brain 'memory\MEMORY.md'
    $line = '- [Ho so chu may va cac du an](facts/ho-so-chu-may.md) - Xung ho, cong ty, du an dang chay, thu muc Drive, quy uoc gui thu'
    if ((Test-Path (Join-Path $brain 'memory\facts\ho-so-chu-may.md')) -and -not $Check) {
        if (-not (Test-Path $memIdx) -or -not (Select-String -Path $memIdx -Pattern 'facts/ho-so-chu-may.md' -SimpleMatch -Quiet)) {
            Add-Content -Path $memIdx -Value $line -Encoding UTF8
        }
    }
    Add-Row 'QLDA team in Javis' $(if ($copied -eq $total -and $total) { 'OK' } else { 'MISSING' }) "$copied / $total files (8 agents, 3 workflows, 2 memory)"
}

# --- 5. AI brains: Javis picks up Claude Code and Antigravity by itself once each CLI is signed in.
# (Javis /providers needs the admin login, so this script does not read it: check Javis > Models.)
Add-Row 'Sign in Claude Code' 'TODO' 'open a terminal: claude  then /login (browser)'
Add-Row 'Sign in Antigravity' 'TODO' 'new PowerShell: & "$env:LOCALAPPDATA\agy\bin\agy.exe" (Google account), then Javis > Models > Antigravity'

$rows | Format-Table -AutoSize -Wrap
'Next (by the owner of the PC, see KET-NOI.md): sign in Claude Desktop, connectors, Javis Models, Antigravity.'
$bad = @($rows | Where-Object { $_.Status -in 'MISSING', 'FAILED' })
if ($bad.Count) { "RESULT: $($bad.Count) item(s) need attention."; exit 1 } else { 'RESULT: AI tools ready.'; exit 0 }
